Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362B4205734
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 18:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbgFWQ3h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 12:29:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56846 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732236AbgFWQ3h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2020 12:29:37 -0400
Received: from 89-64-86-94.dynamic.chello.pl (89.64.86.94) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id a50bd28dfdf2664f; Tue, 23 Jun 2020 18:29:35 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vasily Averin <vvs@virtuozzo.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI / hotplug / PCI: lost acpiphp_put_context in acpiphp_grab_context()
Date:   Tue, 23 Jun 2020 18:29:33 +0200
Message-ID: <7280140.ndZnX9ZZJL@kreacher>
In-Reply-To: <d41ead67-f66d-43fd-7a4c-e4d92adb52f2@virtuozzo.com>
References: <CAJZ5v0gQD_T9WmoF4gv-eDpmKto4_c0pJGiy_7FPiipSGOTrQQ@mail.gmail.com> <d41ead67-f66d-43fd-7a4c-e4d92adb52f2@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, June 23, 2020 1:17:43 AM CEST Vasily Averin wrote:
> v2: followed to rafael@'s proposal
> Fixes: edf5bf34d408 ("ACPI / dock: Use callback pointers from devices' ACPI hotplug contexts")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index b4c92cee13f8..a0923a65e636 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -123,7 +123,11 @@ static struct acpiphp_context *acpiphp_grab_context(struct acpi_device *adev)
>  
>  	acpi_lock_hp_context();
>  	context = acpiphp_get_context(adev);
> -	if (!context || context->func.parent->is_going_away) {
> +	if (context && context->func.parent->is_going_away) {
> +		acpiphp_put_context(context);
> +		context = NULL;
> +	}
> +	if (!context) {
>  		acpi_unlock_hp_context();
>  		return NULL;
>  	}
> 

Thanks for following my suggestion, but it occurred to me that it could still be
done in a better way.

So instead of the above I'd prefer to apply the following change (added PCI and Bjorn
for visibility):

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] PCI: hotplug: ACPI: Fix context refcounting in acpiphp_grab_context()

If context is not NULL in acpiphp_grab_context(), but the
is_going_away flag is set for the device's parent, the reference
counter of the context needs to be decremented before returning
NULL or the context will never be freed, so make that happen.

Fixes: edf5bf34d408 ("ACPI / dock: Use callback pointers from devices' ACPI hotplug contexts")
Reported-by: Vasily Averin <vvs@virtuozzo.com>
Cc: 3.15+ <stable@vger.kernel.org> # 3.15+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -122,13 +122,21 @@ static struct acpiphp_context *acpiphp_g
 	struct acpiphp_context *context;
 
 	acpi_lock_hp_context();
+
 	context = acpiphp_get_context(adev);
-	if (!context || context->func.parent->is_going_away) {
-		acpi_unlock_hp_context();
-		return NULL;
+	if (!context)
+		goto unlock;
+
+	if (context->func.parent->is_going_away) {
+		acpiphp_put_context(context);
+		context = NULL;
+		goto unlock;
 	}
+
 	get_bridge(context->func.parent);
 	acpiphp_put_context(context);
+
+unlock:
 	acpi_unlock_hp_context();
 	return context;
 }




