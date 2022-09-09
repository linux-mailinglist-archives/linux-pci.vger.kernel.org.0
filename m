Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6BF5B4157
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 23:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiIIVSx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 17:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiIIVSw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 17:18:52 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F0D129C66;
        Fri,  9 Sep 2022 14:18:50 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id c0f8f35c6b42e9b1; Fri, 9 Sep 2022 23:18:48 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C10E166D48A;
        Fri,  9 Sep 2022 23:18:47 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        whitehat002 <hackyzh002@gmail.com>
Subject: Re: [PATCH] PCI/ACPI: do not reference a pci device after it has been released
Date:   Fri, 09 Sep 2022 23:18:46 +0200
Message-ID: <5870387.lOV4Wx5bFT@kreacher>
In-Reply-To: <YxrufXoPZnKCxqRP@kroah.com>
References: <20220428142854.1065953-1-gregkh@linuxfoundation.org> <CAJZ5v0hfdnRg0EqG2Zcp9=Kjq+P1NC45iudatisVL_G=QjOC+A@mail.gmail.com> <YxrufXoPZnKCxqRP@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfedthedgudeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
 vghlrdhorhhgpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrtghkhiiihhdttddvsehgmhgrihhlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday, September 9, 2022 9:42:53 AM CEST Greg Kroah-Hartman wrote:
> On Mon, Jun 27, 2022 at 06:37:06PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jun 27, 2022 at 5:07 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Apr 28, 2022 at 10:30:38PM +0200, Rafael J. Wysocki wrote:
> > > > On Thu, Apr 28, 2022 at 10:15 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Thu, Apr 28, 2022 at 6:22 PM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Thu, Apr 28, 2022 at 10:58:58AM -0500, Bjorn Helgaas wrote:
> > > > > > > On Thu, Apr 28, 2022 at 04:28:53PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > In acpi_get_pci_dev(), the debugging message for when a PCI bridge is
> > > > > > > > not found uses a pointer to a pci device whose reference has just been
> > > > > > > > dropped.  The chance that this really is a device that is now been
> > > > > > > > removed from the system is almost impossible to happen, but to be safe,
> > > > > > > > let's print out the debugging message based on the acpi root device
> > > > > > > > which we do have a valid reference to at the moment.
> > > > > > >
> > > > > > > This code was added by 497fb54f578e ("ACPI / PCI: Fix NULL pointer
> > > > > > > dereference in acpi_get_pci_dev() (rev. 2)").  Not sure if it's worth
> > > > > > > a Fixes: tag.
> > > > > >
> > > > > > Can't hurt, I'll add it for the v2 based on this review.
> > > > > >
> > > > > > >
> > > > > > > acpi_get_pci_dev() is used by only five callers, three of which are
> > > > > > > video/backlight related.  I'm always skeptical of one-off interfaces
> > > > > > > like this, but I don't know enough to propose any refactoring or other
> > > > > > > alternatives.
> > > > > > >
> > > > > > > I'll leave this for Rafael, but if I were applying I would silently
> > > > > > > touch up the subject to match convention:
> > > > > > >
> > > > > > >   PCI/ACPI: Do not reference PCI device after it has been released
> > > > > >
> > > > > > Much simpler, thanks.
> > > > > >
> > > > > > >
> > > > > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > > > > > Cc: Len Brown <lenb@kernel.org>
> > > > > > > > Cc: linux-pci@vger.kernel.org
> > > > > > > > Cc: linux-acpi@vger.kernel.org
> > > > > > > > Reported-by: whitehat002 <hackyzh002@gmail.com>
> > > > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > > ---
> > > > > > > >  drivers/acpi/pci_root.c | 3 ++-
> > > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > > > > > > index 6f9e75d14808..ecda378dbc09 100644
> > > > > > > > --- a/drivers/acpi/pci_root.c
> > > > > > > > +++ b/drivers/acpi/pci_root.c
> > > > > > > > @@ -303,7 +303,8 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
> > > > > > > >              * case pdev->subordinate will be NULL for the parent.
> > > > > > > >              */
> > > > > > > >             if (!pbus) {
> > > > > > > > -                   dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
> > > > > > > > +                   dev_dbg(&root->device->dev,
> > > > > > > > +                           "dev %d, function %d is not a PCI-to-PCI bridge\n", dev, fn);
> > > > > > >
> > > > > > > This should use "%02x.%d" to be consistent with the dev_set_name() in
> > > > > > > pci_setup_device().
> > > > > >
> > > > > > Ah, missed that, will change it and send out a new version tomorrow.
> > > > >
> > > > > I would make the change below (modulo the gmail-induced wthite space
> > > > > breakage), though.
> > > >
> > > > That said ->
> > > >
> > > > > ---
> > > > >  drivers/acpi/pci_root.c |    5 +++--
> > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > >
> > > > > Index: linux-pm/drivers/acpi/pci_root.c
> > > > > ===================================================================
> > > > > --- linux-pm.orig/drivers/acpi/pci_root.c
> > > > > +++ linux-pm/drivers/acpi/pci_root.c
> > > > > @@ -295,8 +295,6 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
> > > > >              break;
> > > > >
> > > > >          pbus = pdev->subordinate;
> > > > > -        pci_dev_put(pdev);
> > > > > -
> > > > >          /*
> > > > >           * This function may be called for a non-PCI device that has a
> > > > >           * PCI parent (eg. a disk under a PCI SATA controller).  In that
> > > > > @@ -304,9 +302,12 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
> > > > >           */
> > > > >          if (!pbus) {
> > > > >              dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
> > > > > +            pci_dev_put(pdev);
> > > > >              pdev = NULL;
> > > > >              break;
> > > > >          }
> > > > > +
> > > > > +        pci_dev_put(pdev);
> > > >
> > > > -> we are going to use pbus after this and it is pdev->subordinate
> > > > which cannot survive without pdev AFAICS.
> > > >
> > > > Are we not concerned about this case?
> > >
> > > Good point.
> > >
> > > whitehat002, any ideas?  You found this issue but it really looks like
> > > it is not anything that can ever be hit, so how far do you want to go to
> > > unwind it?
> > 
> > I have an idea, sorry for the delay here.
> > 
> > I should be ready to post something tomorrow.
> 
> Was this ever posted?

No, it wasn't.  Sorry for the glacial pace here.

So the idea is based on the observation that the PCI device returned by the current
code in acpi_get_pci_dev() needs to be registered, so if it corresponds to an ACPI
device object, the struct acpi_device representing it must be registered too and,
moreover, it should be the ACPI companion of that PCI device.  Thus it should be
sufficient to look for it in the ACPI device object's list of physical nodes
corresponding to it.  Hence, the patch below.

I actually can't test it right now (or even compile it for that matter), but
I'll put it in order tomorrow.

---
 drivers/acpi/pci_root.c |   82 +++++++++---------------------------------------
 1 file changed, 16 insertions(+), 66 deletions(-)

Index: linux-pm/drivers/acpi/pci_root.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_root.c
+++ linux-pm/drivers/acpi/pci_root.c
@@ -312,76 +312,26 @@ struct acpi_handle_node {
  */
 struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
 {
-	int dev, fn;
-	unsigned long long adr;
-	acpi_status status;
-	acpi_handle phandle;
-	struct pci_bus *pbus;
-	struct pci_dev *pdev = NULL;
-	struct acpi_handle_node *node, *tmp;
-	struct acpi_pci_root *root;
-	LIST_HEAD(device_list);
-
-	/*
-	 * Walk up the ACPI CA namespace until we reach a PCI root bridge.
-	 */
-	phandle = handle;
-	while (!acpi_is_root_bridge(phandle)) {
-		node = kzalloc(sizeof(struct acpi_handle_node), GFP_KERNEL);
-		if (!node)
-			goto out;
-
-		INIT_LIST_HEAD(&node->node);
-		node->handle = phandle;
-		list_add(&node->node, &device_list);
-
-		status = acpi_get_parent(phandle, &phandle);
-		if (ACPI_FAILURE(status))
-			goto out;
-	}
-
-	root = acpi_pci_find_root(phandle);
-	if (!root)
-		goto out;
-
-	pbus = root->bus;
-
-	/*
-	 * Now, walk back down the PCI device tree until we return to our
-	 * original handle. Assumes that everything between the PCI root
-	 * bridge and the device we're looking for must be a P2P bridge.
-	 */
-	list_for_each_entry(node, &device_list, node) {
-		acpi_handle hnd = node->handle;
-		status = acpi_evaluate_integer(hnd, "_ADR", NULL, &adr);
-		if (ACPI_FAILURE(status))
-			goto out;
-		dev = (adr >> 16) & 0xffff;
-		fn  = adr & 0xffff;
-
-		pdev = pci_get_slot(pbus, PCI_DEVFN(dev, fn));
-		if (!pdev || hnd == handle)
-			break;
-
-		pbus = pdev->subordinate;
-		pci_dev_put(pdev);
-
-		/*
-		 * This function may be called for a non-PCI device that has a
-		 * PCI parent (eg. a disk under a PCI SATA controller).  In that
-		 * case pdev->subordinate will be NULL for the parent.
-		 */
-		if (!pbus) {
-			dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
-			pdev = NULL;
+	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
+	struct acpi_device_physical_node *pn;
+	struct device *pci_dev = NULL;
+
+	if (!adev)
+		return NULL;
+
+	mutex_lock(&adev->physical_node_lock);
+
+	list_for_each_entry(pn, &acpi_dev->physical_node_list, node) {
+		if (dev_is_pci(pn->dev)) {
+			pci_dev = to_pci_dev(pn->dev);
 			break;
 		}
+			
 	}
-out:
-	list_for_each_entry_safe(node, tmp, &device_list, node)
-		kfree(node);
 
-	return pdev;
+	mutex_unlock(&adev->physical_node_lock);
+
+	return pci_dev;
 }
 EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
 



