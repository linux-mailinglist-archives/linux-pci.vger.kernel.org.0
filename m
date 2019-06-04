Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E73DE33EF2
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 08:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFDGYo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 02:24:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13319 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfFDGYo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jun 2019 02:24:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45J22c6Rwqz9vDbl;
        Tue,  4 Jun 2019 08:24:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bLXlcgVXjjBG; Tue,  4 Jun 2019 08:24:40 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45J22c5XHVz9vDbk;
        Tue,  4 Jun 2019 08:24:40 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id B90D1843; Tue,  4 Jun 2019 08:24:39 +0200 (CEST)
Received: from 37-165-91-81.coucou-networks.fr
 (37-165-91-81.coucou-networks.fr [37.165.91.81]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Tue, 04 Jun 2019 08:24:39 +0200
Date:   Tue, 04 Jun 2019 08:24:39 +0200
Message-ID: <20190604082439.Horde.tWsSNlWiTjwbZIMIFhnFcQ5@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI: rpaphp: Avoid a sometimes-uninitialized warning
In-Reply-To: <20190603174323.48251-1-natechancellor@gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Quoting Nathan Chancellor <natechancellor@gmail.com>:

> When building with -Wsometimes-uninitialized, clang warns:
>
> drivers/pci/hotplug/rpaphp_core.c:243:14: warning: variable 'fndit' is
> used uninitialized whenever 'for' loop exits because its condition is
> false [-Wsometimes-uninitialized]
>         for (j = 0; j < entries; j++) {
>                     ^~~~~~~~~~~
> drivers/pci/hotplug/rpaphp_core.c:256:6: note: uninitialized use occurs
> here
>         if (fndit)
>             ^~~~~
> drivers/pci/hotplug/rpaphp_core.c:243:14: note: remove the condition if
> it is always true
>         for (j = 0; j < entries; j++) {
>                     ^~~~~~~~~~~
> drivers/pci/hotplug/rpaphp_core.c:233:14: note: initialize the variable
> 'fndit' to silence this warning
>         int j, fndit;
>                     ^
>                      = 0
>
> Looking at the loop in a vacuum as clang would, fndit could be
> uninitialized if entries was ever zero or the if statement was
> always true within the loop. Regardless of whether or not this
> warning is a problem in practice, "found" variables should always
> be initialized to false so that there is no possibility of
> undefined behavior.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/504
> Fixes: 2fcf3ae508c2 ("hotplug/drc-info: Add code to search  
> ibm,drc-info property")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/pci/hotplug/rpaphp_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/rpaphp_core.c  
> b/drivers/pci/hotplug/rpaphp_core.c
> index bcd5d357ca23..07b56bf2886f 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -230,7 +230,7 @@ static int rpaphp_check_drc_props_v2(struct  
> device_node *dn, char *drc_name,
>  	struct of_drc_info drc;
>  	const __be32 *value;
>  	char cell_drc_name[MAX_DRC_NAME_LEN];
> -	int j, fndit;
> +	int j, fndit = 0;

Not sure fndit is needed at all. Looking into the full function code,  
fndit only serves as doing a single action. That action could be done  
in the loop directly, see below

And while you are at it, I guess you should also handle the  
initialisation of cell_drc_name.
In the current code, it looks like content of cell_drc_name is  
undefined when doing the strcmp when fndit is not 1.

>
>  	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
>  	if (info == NULL)
> --
> 2.22.0.rc2

diff --git a/drivers/pci/hotplug/rpaphp_core.c  
b/drivers/pci/hotplug/rpaphp_core.c
index bcd5d357ca23..87113419a44f 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -230,7 +230,7 @@ static int rpaphp_check_drc_props_v2(struct  
device_node *dn, char *drc_name,
  	struct of_drc_info drc;
  	const __be32 *value;
  	char cell_drc_name[MAX_DRC_NAME_LEN];
-	int j, fndit;
+	int j;

  	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
  	if (info == NULL)
@@ -248,14 +248,10 @@ static int rpaphp_check_drc_props_v2(struct  
device_node *dn, char *drc_name,
  		if (my_index > drc.last_drc_index)
  			continue;

-		fndit = 1;
+		/* Found it */
+		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix, my_index);
  		break;
  	}
-	/* Found it */
-
-	if (fndit)
-		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
-			my_index);

  	if (((drc_name == NULL) ||
  	     (drc_name && !strcmp(drc_name, cell_drc_name))) &&

Christophe
