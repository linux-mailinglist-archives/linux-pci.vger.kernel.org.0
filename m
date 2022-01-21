Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB70849667F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 21:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiAUUnO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 15:43:14 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:52064 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiAUUnN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 15:43:13 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (1024 bits) client-digest SHA256)
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 8897F1C0BA9
        for <linux-pci@vger.kernel.org>; Fri, 21 Jan 2022 21:43:10 +0100 (CET)
Received: by albireo.burrow.ucw.cz (Postfix, from userid 1000)
        id D120D1A04E6; Fri, 21 Jan 2022 21:43:09 +0100 (CET)
Date:   Fri, 21 Jan 2022 21:43:09 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils 3/5] libpci: generic: Implement SUBSYS also for
 PCI_HEADER_TYPE_BRIDGE
Message-ID: <mj+md-20220121.204228.64783.albireo@ucw.cz>
References: <20220121135718.27172-1-pali@kernel.org>
 <20220121135718.27172-4-pali@kernel.org>
 <mj+md-20220121.144016.17855.nikam@ucw.cz>
 <20220121161147.n6byckl4rnezfgy6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121161147.n6byckl4rnezfgy6@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Rspamd-Queue-Id: 8897F1C0BA9
X-Spam-Status: No, score=-1.49
X-Spamd-Bar: -
Authentication-Results: jabberwock.ucw.cz;
        dkim=none;
        dmarc=none;
        spf=none (jabberwock.ucw.cz: domain of mj@ucw.cz has no SPF policy when checking 91.219.245.20) smtp.mailfrom=mj@ucw.cz
X-Spamd-Result: default: False [-1.49 / 15.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         HFILTER_HELO_IP_A(1.00)[albireo.burrow.ucw.cz];
         DMARC_NA(0.00)[ucw.cz];
         SENDER_REP_HAM(-0.69)[asn: 51744(-0.18), country: CZ(-0.01), ip: 91.219.245.20(-0.51)];
         RCPT_COUNT_FIVE(0.00)[5];
         AUTH_NA(1.00)[];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[albireo.burrow.ucw.cz];
         NEURAL_HAM(-0.00)[-1.000];
         R_SPF_NA(0.00)[no SPF record];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:51744, ipnet:91.219.244.0/22, country:CZ];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_FROM(0.00)[f-210122,linux-pci=vger.kernel.org]
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> Current libpci code which walks capability list is in functions
> pci_scan_caps() and pci_find_cap(). But pci_find_cap() calls
> pci_fill_info() (only with PCI_FILL_CAPS flag). So I'm not sure if it is
> a good idea to call pci_find_cap() from pci_generic_fill_info().

Still, the right solution is to change pci_fill_info() to allow recursion :)

Here is my try.

					Martin



commit 8e9299e4dde0bb73f2d571dc6e3b522f88d5765d
Author: Martin Mares <mj@ucw.cz>
Date:   Fri Jan 21 21:39:18 2022 +0100

    Simplified pci_fill_info() and friends
    
    Previously, we kept track of which fields were already filled, which
    was quite brittle.
    
    Now we keep only the set of already known fields in struct pci_dev.
    We check if the current field is needed against this information.
    
    Not only this simplifies the whole thing, but it also enables future
    back-ends to call pci_fill_info() recursively as needed.

diff --git a/lib/access.c b/lib/access.c
index b257849..9bd6989 100644
--- a/lib/access.c
+++ b/lib/access.c
@@ -1,7 +1,7 @@
 /*
  *	The PCI Library -- User Access
  *
- *	Copyright (c) 1997--2018 Martin Mares <mj@ucw.cz>
+ *	Copyright (c) 1997--2022 Martin Mares <mj@ucw.cz>
  *
  *	Can be freely distributed and used under the terms of the GNU GPL.
  */
@@ -198,7 +198,7 @@ pci_fill_info_v35(struct pci_dev *d, int flags)
       pci_reset_properties(d);
     }
   if (uflags & ~d->known_fields)
-    d->known_fields |= d->methods->fill_info(d, flags & ~d->known_fields);
+    d->methods->fill_info(d, uflags);
   return d->known_fields;
 }
 
diff --git a/lib/caps.c b/lib/caps.c
index c3b9180..3c025a9 100644
--- a/lib/caps.c
+++ b/lib/caps.c
@@ -80,17 +80,16 @@ pci_scan_ext_caps(struct pci_dev *d)
   while (where);
 }
 
-unsigned int
+void
 pci_scan_caps(struct pci_dev *d, unsigned int want_fields)
 {
-  if ((want_fields & PCI_FILL_EXT_CAPS) && !(d->known_fields & PCI_FILL_CAPS))
+  if (want_fields & PCI_FILL_EXT_CAPS)
     want_fields |= PCI_FILL_CAPS;
 
-  if (want_fields & PCI_FILL_CAPS)
+  if (want_fill(d, want_fields, PCI_FILL_CAPS))
     pci_scan_trad_caps(d);
-  if (want_fields & PCI_FILL_EXT_CAPS)
+  if (want_fill(d, want_fields, PCI_FILL_EXT_CAPS))
     pci_scan_ext_caps(d);
-  return want_fields;
 }
 
 void
diff --git a/lib/fbsd-device.c b/lib/fbsd-device.c
index cffab69..396ff1d 100644
--- a/lib/fbsd-device.c
+++ b/lib/fbsd-device.c
@@ -159,7 +159,7 @@ fbsd_scan(struct pci_access *a)
   free(matches);
 }
 
-static int
+static void
 fbsd_fill_info(struct pci_dev *d, int flags)
 {
   struct pci_conf_io conf;
@@ -200,16 +200,14 @@ fbsd_fill_info(struct pci_dev *d, int flags)
       d->access->error("fbsd_fill_info: ioctl(PCIOCGETCONF) failed: %s", strerror(errno));
     }
 
-  if (flags & PCI_FILL_IDENT)
+  if (want_fill(d, flags, PCI_FILL_IDENT))
     {
       d->vendor_id = match.pc_vendor;
       d->device_id = match.pc_device;
     }
-  if (flags & PCI_FILL_CLASS)
-    {
-      d->device_class = (match.pc_class << 8) | match.pc_subclass;
-    }
-  if (flags & (PCI_FILL_BASES | PCI_FILL_SIZES))
+  if (want_fill(d, flags, PCI_FILL_CLASS))
+    d->device_class = (match.pc_class << 8) | match.pc_subclass;
+  if (want_fill(d, flags PCI_FILL_BASES | PCI_FILL_SIZES))
     {
       d->rom_base_addr = 0;
       d->rom_size = 0;
@@ -242,9 +240,6 @@ fbsd_fill_info(struct pci_dev *d, int flags)
 	    }
 	}
     }
-
-  return flags & (PCI_FILL_IDENT | PCI_FILL_CLASS | PCI_FILL_BASES |
-		  PCI_FILL_SIZES);
 }
 
 static int
diff --git a/lib/generic.c b/lib/generic.c
index ef9e2a3..e80158f 100644
--- a/lib/generic.c
+++ b/lib/generic.c
@@ -1,7 +1,7 @@
 /*
  *	The PCI Library -- Generic Direct Access Functions
  *
- *	Copyright (c) 1997--2000 Martin Mares <mj@ucw.cz>
+ *	Copyright (c) 1997--2022 Martin Mares <mj@ucw.cz>
  *
  *	Can be freely distributed and used under the terms of the GNU GPL.
  */
@@ -74,39 +74,36 @@ pci_generic_scan(struct pci_access *a)
   pci_generic_scan_bus(a, busmap, 0);
 }
 
-unsigned int
+static int
+get_hdr_type(struct pci_dev *d)
+{
+  if (d->hdrtype < 0)
+    d->hdrtype = pci_read_byte(d, PCI_HEADER_TYPE) & 0x7f;
+  return d->hdrtype;
+}
+
+void
 pci_generic_fill_info(struct pci_dev *d, unsigned int flags)
 {
   struct pci_access *a = d->access;
-  unsigned int done = 0;
 
-  if ((flags & (PCI_FILL_BASES | PCI_FILL_ROM_BASE)) && d->hdrtype < 0)
-    d->hdrtype = pci_read_byte(d, PCI_HEADER_TYPE) & 0x7f;
-
-  if (flags & PCI_FILL_IDENT)
+  if (want_fill(d, flags, PCI_FILL_IDENT))
     {
       d->vendor_id = pci_read_word(d, PCI_VENDOR_ID);
       d->device_id = pci_read_word(d, PCI_DEVICE_ID);
-      done |= PCI_FILL_IDENT;
     }
 
-  if (flags & PCI_FILL_CLASS)
-    {
-      d->device_class = pci_read_word(d, PCI_CLASS_DEVICE);
-      done |= PCI_FILL_CLASS;
-    }
+  if (want_fill(d, flags, PCI_FILL_CLASS))
+    d->device_class = pci_read_word(d, PCI_CLASS_DEVICE);
 
-  if (flags & PCI_FILL_IRQ)
-    {
-      d->irq = pci_read_byte(d, PCI_INTERRUPT_LINE);
-      done |= PCI_FILL_IRQ;
-    }
+  if (want_fill(d, flags, PCI_FILL_IRQ))
+    d->irq = pci_read_byte(d, PCI_INTERRUPT_LINE);
 
-  if (flags & PCI_FILL_BASES)
+  if (want_fill(d, flags, PCI_FILL_BASES))
     {
       int cnt = 0, i;
       memset(d->base_addr, 0, sizeof(d->base_addr));
-      switch (d->hdrtype)
+      switch (get_hdr_type(d))
 	{
 	case PCI_HEADER_TYPE_NORMAL:
 	  cnt = 6;
@@ -148,14 +145,13 @@ pci_generic_fill_info(struct pci_dev *d, unsigned int flags)
 		}
 	    }
 	}
-      done |= PCI_FILL_BASES;
     }
 
-  if (flags & PCI_FILL_ROM_BASE)
+  if (want_fill(d, flags, PCI_FILL_ROM_BASE))
     {
       int reg = 0;
       d->rom_base_addr = 0;
-      switch (d->hdrtype)
+      switch (get_hdr_type(d))
 	{
 	case PCI_HEADER_TYPE_NORMAL:
 	  reg = PCI_ROM_ADDRESS;
@@ -170,13 +166,9 @@ pci_generic_fill_info(struct pci_dev *d, unsigned int flags)
 	  if (u != 0xffffffff)
 	    d->rom_base_addr = u;
 	}
-      done |= PCI_FILL_ROM_BASE;
     }
 
-  if (flags & (PCI_FILL_CAPS | PCI_FILL_EXT_CAPS))
-    done |= pci_scan_caps(d, flags);
-
-  return done;
+  pci_scan_caps(d, flags);
 }
 
 static int
diff --git a/lib/hurd.c b/lib/hurd.c
index 90cf89f..0939a20 100644
--- a/lib/hurd.c
+++ b/lib/hurd.c
@@ -328,26 +328,16 @@ hurd_fill_rom(struct pci_dev *d)
   d->rom_size = rom.size;
 }
 
-static unsigned int
+static void
 hurd_fill_info(struct pci_dev *d, unsigned int flags)
 {
-  unsigned int done = 0;
-
   if (!d->access->buscentric)
     {
-      if (flags & (PCI_FILL_BASES | PCI_FILL_SIZES))
-	{
-	  hurd_fill_regions(d);
-	  done |= PCI_FILL_BASES | PCI_FILL_SIZES;
-	}
-      if (flags & PCI_FILL_ROM_BASE)
-	{
-	  hurd_fill_rom(d);
-	  done |= PCI_FILL_ROM_BASE;
-	}
+      if (want_fill(d, flags, PCI_FILL_BASES | PCI_FILL_SIZES))
+	hurd_fill_regions(d);
+      if (want_fill(d, flags, PCI_FILL_ROM_BASE))
+	hurd_fill_rom(d);
     }
-
-  return done | pci_generic_fill_info(d, flags & ~done);
 }
 
 struct pci_methods pm_hurd = {
diff --git a/lib/internal.h b/lib/internal.h
index 17c27e1..942e3cb 100644
--- a/lib/internal.h
+++ b/lib/internal.h
@@ -1,7 +1,7 @@
 /*
  *	The PCI Library -- Internal Stuff
  *
- *	Copyright (c) 1997--2018 Martin Mares <mj@ucw.cz>
+ *	Copyright (c) 1997--2022 Martin Mares <mj@ucw.cz>
  *
  *	Can be freely distributed and used under the terms of the GNU GPL.
  */
@@ -41,7 +41,7 @@ struct pci_methods {
   void (*init)(struct pci_access *);
   void (*cleanup)(struct pci_access *);
   void (*scan)(struct pci_access *);
-  unsigned int (*fill_info)(struct pci_dev *, unsigned int flags);
+  void (*fill_info)(struct pci_dev *, unsigned int flags);
   int (*read)(struct pci_dev *, int pos, byte *buf, int len);
   int (*write)(struct pci_dev *, int pos, byte *buf, int len);
   int (*read_vpd)(struct pci_dev *, int pos, byte *buf, int len);
@@ -52,7 +52,7 @@ struct pci_methods {
 /* generic.c */
 void pci_generic_scan_bus(struct pci_access *, byte *busmap, int bus);
 void pci_generic_scan(struct pci_access *);
-unsigned int pci_generic_fill_info(struct pci_dev *, unsigned int flags);
+void pci_generic_fill_info(struct pci_dev *, unsigned int flags);
 int pci_generic_block_read(struct pci_dev *, int pos, byte *buf, int len);
 int pci_generic_block_write(struct pci_dev *, int pos, byte *buf, int len);
 
@@ -75,6 +75,18 @@ int pci_fill_info_v33(struct pci_dev *, int flags) VERSIONED_ABI;
 int pci_fill_info_v34(struct pci_dev *, int flags) VERSIONED_ABI;
 int pci_fill_info_v35(struct pci_dev *, int flags) VERSIONED_ABI;
 
+static inline int want_fill(struct pci_dev *d, unsigned want_fields, unsigned int try_fields)
+{
+  want_fields &= try_fields;
+  if ((d->known_fields & want_fields) == want_fields)
+    return 0;
+  else
+    {
+      d->known_fields |= try_fields;
+      return 1;
+    }
+}
+
 struct pci_property {
   struct pci_property *next;
   u32 key;
@@ -89,7 +101,7 @@ int pci_set_param_internal(struct pci_access *acc, char *param, char *val, int c
 void pci_free_params(struct pci_access *acc);
 
 /* caps.c */
-unsigned int pci_scan_caps(struct pci_dev *, unsigned int want_fields);
+void pci_scan_caps(struct pci_dev *, unsigned int want_fields);
 void pci_free_caps(struct pci_dev *);
 
 extern struct pci_methods pm_intel_conf1, pm_intel_conf2, pm_linux_proc,
diff --git a/lib/sysfs.c b/lib/sysfs.c
index fb64241..4b8b2cd 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -288,11 +288,9 @@ sysfs_fill_slots(struct pci_access *a)
   closedir(dir);
 }
 
-static unsigned int
+static void
 sysfs_fill_info(struct pci_dev *d, unsigned int flags)
 {
-  unsigned int done = 0;
-
   if (!d->access->buscentric)
     {
       /*
@@ -300,61 +298,45 @@ sysfs_fill_info(struct pci_dev *d, unsigned int flags)
        *  the kernel's view, which has regions and IRQs remapped and other fields
        *  (most importantly classes) possibly fixed if the device is known broken.
        */
-      if (flags & PCI_FILL_IDENT)
+      if (want_fill(d, flags, PCI_FILL_IDENT))
 	{
 	  d->vendor_id = sysfs_get_value(d, "vendor", 1);
 	  d->device_id = sysfs_get_value(d, "device", 1);
-	  done |= PCI_FILL_IDENT;
 	}
-      if (flags & PCI_FILL_CLASS)
-	{
-	  d->device_class = sysfs_get_value(d, "class", 1) >> 8;
-	  done |= PCI_FILL_CLASS;
-	}
-      if (flags & PCI_FILL_IRQ)
-	{
+      if (want_fill(d, flags, PCI_FILL_CLASS))
+	d->device_class = sysfs_get_value(d, "class", 1) >> 8;
+      if (want_fill(d, flags, PCI_FILL_IRQ))
 	  d->irq = sysfs_get_value(d, "irq", 1);
-	  done |= PCI_FILL_IRQ;
-	}
-      if (flags & (PCI_FILL_BASES | PCI_FILL_ROM_BASE | PCI_FILL_SIZES | PCI_FILL_IO_FLAGS))
-	{
+      if (want_fill(d, flags, PCI_FILL_BASES | PCI_FILL_ROM_BASE | PCI_FILL_SIZES | PCI_FILL_IO_FLAGS))
 	  sysfs_get_resources(d);
-	  done |= PCI_FILL_BASES | PCI_FILL_ROM_BASE | PCI_FILL_SIZES | PCI_FILL_IO_FLAGS;
-	}
     }
 
-  if (flags & PCI_FILL_PHYS_SLOT)
+  if (want_fill(d, flags, PCI_FILL_PHYS_SLOT))
     {
       struct pci_dev *pd;
       sysfs_fill_slots(d->access);
       for (pd = d->access->devices; pd; pd = pd->next)
 	pd->known_fields |= PCI_FILL_PHYS_SLOT;
-      done |= PCI_FILL_PHYS_SLOT;
     }
 
-  if (flags & PCI_FILL_MODULE_ALIAS)
+  if (want_fill(d, flags, PCI_FILL_MODULE_ALIAS))
     {
       char buf[OBJBUFSIZE];
       if (sysfs_get_string(d, "modalias", buf, 0))
 	d->module_alias = pci_set_property(d, PCI_FILL_MODULE_ALIAS, buf);
-      done |= PCI_FILL_MODULE_ALIAS;
     }
 
-  if (flags & PCI_FILL_LABEL)
+  if (want_fill(d, flags, PCI_FILL_LABEL))
     {
       char buf[OBJBUFSIZE];
       if (sysfs_get_string(d, "label", buf, 0))
 	d->label = pci_set_property(d, PCI_FILL_LABEL, buf);
-      done |= PCI_FILL_LABEL;
     }
 
-  if (flags & PCI_FILL_NUMA_NODE)
-    {
-      d->numa_node = sysfs_get_value(d, "numa_node", 0);
-      done |= PCI_FILL_NUMA_NODE;
-    }
+  if (want_fill(d, flags, PCI_FILL_NUMA_NODE))
+    d->numa_node = sysfs_get_value(d, "numa_node", 0);
 
-  if (flags & PCI_FILL_IOMMU_GROUP)
+  if (want_fill(d, flags, PCI_FILL_IOMMU_GROUP))
     {
       char *group_link = sysfs_deref_link(d, "iommu_group");
       if (group_link)
@@ -362,10 +344,9 @@ sysfs_fill_info(struct pci_dev *d, unsigned int flags)
           pci_set_property(d, PCI_FILL_IOMMU_GROUP, basename(group_link));
           free(group_link);
         }
-      done |= PCI_FILL_IOMMU_GROUP;
     }
 
-  if (flags & PCI_FILL_DT_NODE)
+  if (want_fill(d, flags, PCI_FILL_DT_NODE))
     {
       char *node = sysfs_deref_link(d, "of_node");
       if (node)
@@ -373,10 +354,9 @@ sysfs_fill_info(struct pci_dev *d, unsigned int flags)
 	  pci_set_property(d, PCI_FILL_DT_NODE, node);
 	  free(node);
 	}
-      done |= PCI_FILL_DT_NODE;
     }
 
-  return done | pci_generic_fill_info(d, flags & ~done);
+  pci_generic_fill_info(d, flags);
 }
 
 /* Intent of the sysfs_setup() caller */
