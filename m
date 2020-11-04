Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DADB2A5D96
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 06:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgKDFNH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 00:13:07 -0500
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:50732 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728415AbgKDFNH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 00:13:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 6EF11180A813D;
        Wed,  4 Nov 2020 05:13:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:327:355:379:599:960:966:967:968:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:1801:2196:2198:2199:2200:2393:2525:2553:2560:2563:2682:2685:2693:2828:2859:2896:2898:2902:2904:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4385:4470:4605:4823:5007:6119:7875:7974:8599:8784:8957:9010:9025:9121:10004:10848:11026:11232:11233:11473:11658:11914:12043:12257:12296:12297:12438:12555:12663:12683:12698:12737:12740:12760:12895:12986:13025:13439:13972:14096:14097:14659:21067:21080:21433:21451:21611:21627:21740:21773:21939:21990:30003:30045:30046:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: robin63_1109d44272be
X-Filterd-Recvd-Size: 29569
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Nov 2020 05:13:01 +0000 (UTC)
Message-ID: <6e392d099bd8aaba14223aa770361dbdeeab271b.camel@perches.com>
Subject: Re: [PATCH] ACPI: Remove trailing whitespace
From:   Joe Perches <joe@perches.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 Nov 2020 21:13:00 -0800
In-Reply-To: <c92703e3-c964-b4a6-e3df-c4c0c28b44c1@gmail.com>
References: <20201103211259.GA265488@bjorn-Precision-5520>
         <c92703e3-c964-b4a6-e3df-c4c0c28b44c1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-11-03 at 22:30 +0100, Maximilian Luz wrote:
> On 11/3/20 10:12 PM, Bjorn Helgaas wrote:
> > On Mon, Nov 02, 2020 at 02:36:41PM +0100, Maximilian Luz wrote:
> > > Remove trailing whitespace and fix some whitespace inconsitencies while
> > > at it.
> > 
> > I'm OK with this as long as somebody fixes the
> > s/inconsitencies/inconsistencies/
> 
> Sorry about that, I can resubmit if necessary.
> 
> > above.  I assume you've scanned all of drivers/acpi/ for similar
> > issues so they can all be fixed at once.
> 
> Yes. I scanned drivers/acpi for trailing whitespaces after I noticed a
> couple of them. I did not explicitly scan for other stuff like spaces
> where there should be tabs, mostly because I haven't found a quick and
> reliable solution for that. I only noticed an inconsistent indentation
> when committing, so I fixed that too.

You could try:

$ git ls-files -- 'drivers/acpi/*.[ch]' | \
  xargs ./scripts/checkpatch.pl -f --fix-inplace --types=CODE_INDENT

Right now that produces:
---
 drivers/acpi/ac.c                   |  6 +++---
 drivers/acpi/acpi_processor.c       |  6 +++---
 drivers/acpi/acpi_video.c           |  6 +++---
 drivers/acpi/acpica/rslist.c        |  2 +-
 drivers/acpi/battery.c              |  6 +++---
 drivers/acpi/bus.c                  | 12 ++++++------
 drivers/acpi/button.c               |  4 ++--
 drivers/acpi/ec.c                   |  2 +-
 drivers/acpi/event.c                |  2 +-
 drivers/acpi/internal.h             | 16 ++++++++--------
 drivers/acpi/nfit/core.c            | 10 +++++-----
 drivers/acpi/pci_irq.c              |  4 ++--
 drivers/acpi/pci_link.c             |  6 +++---
 drivers/acpi/pci_mcfg.c             |  2 +-
 drivers/acpi/power.c                |  6 +++---
 drivers/acpi/processor_perflib.c    |  2 +-
 drivers/acpi/processor_throttling.c |  2 +-
 drivers/acpi/sbs.c                  |  6 +++---
 drivers/acpi/sbshc.c                |  2 +-
 drivers/acpi/sbshc.h                |  2 +-
 drivers/acpi/scan.c                 |  2 +-
 drivers/acpi/thermal.c              |  4 ++--
 drivers/acpi/utils.c                |  2 +-
 drivers/acpi/video_detect.c         | 16 ++++++++--------
 drivers/acpi/wakeup.c               |  4 ++--
 25 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 46a64e9fa716..46be80976a03 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -89,7 +89,7 @@ struct acpi_ac {
 #define to_acpi_ac(x) power_supply_get_drvdata(x)
 
 /* --------------------------------------------------------------------------
-                               AC Adapter Management
+			       AC Adapter Management
    -------------------------------------------------------------------------- */
 
 static int acpi_ac_get_state(struct acpi_ac *ac)
@@ -112,7 +112,7 @@ static int acpi_ac_get_state(struct acpi_ac *ac)
 }
 
 /* --------------------------------------------------------------------------
-                            sysfs I/F
+			    sysfs I/F
    -------------------------------------------------------------------------- */
 static int get_ac_property(struct power_supply *psy,
 			   enum power_supply_property psp,
@@ -141,7 +141,7 @@ static enum power_supply_property ac_props[] = {
 };
 
 /* --------------------------------------------------------------------------
-                                   Driver Model
+				   Driver Model
    -------------------------------------------------------------------------- */
 
 static void acpi_ac_notify(struct acpi_device *device, u32 event)
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 2ee5e05a0d69..b45102e4fbfc 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -30,7 +30,7 @@ DEFINE_PER_CPU(struct acpi_processor *, processors);
 EXPORT_PER_CPU_SYMBOL(processors);
 
 /* --------------------------------------------------------------------------
-                                Errata Handling
+				Errata Handling
    -------------------------------------------------------------------------- */
 
 struct acpi_processor_errata errata __read_mostly;
@@ -158,7 +158,7 @@ static int acpi_processor_errata(void)
 }
 
 /* --------------------------------------------------------------------------
-                                Initialization
+				Initialization
    -------------------------------------------------------------------------- */
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
@@ -441,7 +441,7 @@ static int acpi_processor_add(struct acpi_device *device,
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* --------------------------------------------------------------------------
-                                    Removal
+				    Removal
    -------------------------------------------------------------------------- */
 
 static void acpi_processor_remove(struct acpi_device *device)
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index bc96457c9e25..a322a7bd286b 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -578,7 +578,7 @@ acpi_video_bqc_value_to_level(struct acpi_video_device *device,
 				ACPI_VIDEO_FIRST_LEVEL - 1 - bqc_value;
 
 		level = device->brightness->levels[bqc_value +
-		                                   ACPI_VIDEO_FIRST_LEVEL];
+						   ACPI_VIDEO_FIRST_LEVEL];
 	} else {
 		level = bqc_value;
 	}
@@ -990,8 +990,8 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 		goto out_free_levels;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-	                  "found %d brightness levels\n",
-	                  br->count - ACPI_VIDEO_FIRST_LEVEL));
+			  "found %d brightness levels\n",
+			  br->count - ACPI_VIDEO_FIRST_LEVEL));
 	return 0;
 
 out_free_levels:
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 0307675d37be..105739aebc39 100644
--- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -177,7 +177,7 @@ acpi_rs_convert_resources_to_aml(struct acpi_resource *resource,
 		}
 
 		status = acpi_rs_convert_resource_to_aml(resource,
-						         ACPI_CAST_PTR(union
+							 ACPI_CAST_PTR(union
 								       aml_resource,
 								       aml),
 							 conversion_table);
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index cab4af532f36..d27448b3369b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -378,7 +378,7 @@ static enum power_supply_property energy_battery_full_cap_broken_props[] = {
 };
 
 /* --------------------------------------------------------------------------
-                               Battery Management
+			       Battery Management
    -------------------------------------------------------------------------- */
 struct acpi_offsets {
 	size_t offset;		/* offset inside struct acpi_sbs_battery */
@@ -987,7 +987,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 	 */
 	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
 	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
-            (battery->capacity_now <= battery->alarm)))
+	    (battery->capacity_now <= battery->alarm)))
 		acpi_pm_wakeup_event(&battery->device->dev);
 
 	return result;
@@ -1013,7 +1013,7 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 }
 
 /* --------------------------------------------------------------------------
-                                 Driver Interface
+				 Driver Interface
    -------------------------------------------------------------------------- */
 
 static void acpi_battery_notify(struct acpi_device *device, u32 event)
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 1682f8b454a2..1d48e63cce49 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -72,7 +72,7 @@ static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
 #endif
 
 /* --------------------------------------------------------------------------
-                                Device Management
+				Device Management
    -------------------------------------------------------------------------- */
 
 acpi_status acpi_bus_get_status_handle(acpi_handle handle,
@@ -335,7 +335,7 @@ static void acpi_bus_osc_support(void)
 }
 
 /* --------------------------------------------------------------------------
-                             Notification Handling
+			     Notification Handling
    -------------------------------------------------------------------------- */
 
 /**
@@ -527,7 +527,7 @@ static int __init acpi_setup_sb_notify_handler(void)
 }
 
 /* --------------------------------------------------------------------------
-                             Device Matching
+			     Device Matching
    -------------------------------------------------------------------------- */
 
 /**
@@ -839,7 +839,7 @@ bool acpi_driver_match_device(struct device *dev,
 EXPORT_SYMBOL_GPL(acpi_driver_match_device);
 
 /* --------------------------------------------------------------------------
-                              ACPI Driver Management
+			      ACPI Driver Management
    -------------------------------------------------------------------------- */
 
 /**
@@ -881,7 +881,7 @@ void acpi_bus_unregister_driver(struct acpi_driver *driver)
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
 
 /* --------------------------------------------------------------------------
-                              ACPI Bus operations
+			      ACPI Bus operations
    -------------------------------------------------------------------------- */
 
 static int acpi_bus_match(struct device *dev, struct device_driver *drv)
@@ -964,7 +964,7 @@ struct bus_type acpi_bus_type = {
 };
 
 /* --------------------------------------------------------------------------
-                             Initialization/Cleanup
+			     Initialization/Cleanup
    -------------------------------------------------------------------------- */
 
 static int __init acpi_bus_init_irq(void)
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 0761529cac05..746661794c51 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -151,7 +151,7 @@ module_param(lid_report_interval, ulong, 0644);
 MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
 
 /* --------------------------------------------------------------------------
-                              FS Interface (/proc)
+			      FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
 static struct proc_dir_entry *acpi_button_dir;
@@ -343,7 +343,7 @@ static int acpi_button_remove_fs(struct acpi_device *device)
 }
 
 /* --------------------------------------------------------------------------
-                                Driver Interface
+				Driver Interface
    -------------------------------------------------------------------------- */
 int acpi_lid_open(void)
 {
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e0cb1bcfffb2..05c2f506fb09 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1037,7 +1037,7 @@ void acpi_ec_unblock_transactions(void)
 }
 
 /* --------------------------------------------------------------------------
-                                Event Management
+				Event Management
    -------------------------------------------------------------------------- */
 static struct acpi_ec_query_handler *
 acpi_ec_get_query_handler_by_value(struct acpi_ec *ec, u8 value)
diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 170643927044..92e59f45329b 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -31,7 +31,7 @@ int acpi_notifier_call_chain(struct acpi_device *dev, u32 type, u32 data)
 	event.type = type;
 	event.data = data;
 	return (blocking_notifier_call_chain(&acpi_chain_head, 0, (void *)&event)
-                        == NOTIFY_BAD) ? -EINVAL : 0;
+			== NOTIFY_BAD) ? -EINVAL : 0;
 }
 EXPORT_SYMBOL(acpi_notifier_call_chain);
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 43411a7457cd..ac22802bf9b6 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -89,7 +89,7 @@ acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
 void acpi_scan_table_handler(u32 event, void *table, void *context);
 
 /* --------------------------------------------------------------------------
-                     Device Node Initialization / Removal
+		     Device Node Initialization / Removal
    -------------------------------------------------------------------------- */
 #define ACPI_STA_DEFAULT (ACPI_STA_DEVICE_PRESENT | ACPI_STA_DEVICE_ENABLED | \
 			  ACPI_STA_DEVICE_UI | ACPI_STA_DEVICE_FUNCTIONING)
@@ -117,14 +117,14 @@ bool acpi_device_is_first_physical_node(struct acpi_device *adev,
 int acpi_bus_register_early_device(int type);
 
 /* --------------------------------------------------------------------------
-                     Device Matching and Notification
+		     Device Matching and Notification
    -------------------------------------------------------------------------- */
 struct acpi_device *acpi_companion_match(const struct device *dev);
 int __acpi_device_uevent_modalias(struct acpi_device *adev,
 				  struct kobj_uevent_env *env);
 
 /* --------------------------------------------------------------------------
-                                  Power Resource
+				  Power Resource
    -------------------------------------------------------------------------- */
 int acpi_power_init(void);
 void acpi_power_resources_list_free(struct list_head *list);
@@ -134,19 +134,19 @@ int acpi_add_power_resource(acpi_handle handle);
 void acpi_power_add_remove_device(struct acpi_device *adev, bool add);
 int acpi_power_wakeup_list_init(struct list_head *list, int *system_level);
 int acpi_device_sleep_wake(struct acpi_device *dev,
-                           int enable, int sleep_state, int dev_state);
+			   int enable, int sleep_state, int dev_state);
 int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
 int acpi_power_on_resources(struct acpi_device *device, int state);
 int acpi_power_transition(struct acpi_device *device, int state);
 
 /* --------------------------------------------------------------------------
-                              Device Power Management
+			      Device Power Management
    -------------------------------------------------------------------------- */
 int acpi_device_get_power(struct acpi_device *device, int *state);
 int acpi_wakeup_device_init(void);
 
 /* --------------------------------------------------------------------------
-                                  Processor
+				  Processor
    -------------------------------------------------------------------------- */
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
 void acpi_early_processor_set_pdc(void);
@@ -161,7 +161,7 @@ static inline void acpi_early_processor_osc(void) {}
 #endif
 
 /* --------------------------------------------------------------------------
-                                  Embedded Controller
+				  Embedded Controller
    -------------------------------------------------------------------------- */
 struct acpi_ec {
 	acpi_handle handle;
@@ -207,7 +207,7 @@ bool acpi_ec_dispatch_gpe(void);
 
 
 /*--------------------------------------------------------------------------
-                                  Suspend/Resume
+				  Suspend/Resume
   -------------------------------------------------------------------------- */
 #ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
 extern bool acpi_s2idle_wakeup(void);
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 3a3c209ed3d3..442608220b5c 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2175,10 +2175,10 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
  * these commands.
  */
 enum nfit_aux_cmds {
-        NFIT_CMD_TRANSLATE_SPA = 5,
-        NFIT_CMD_ARS_INJECT_SET = 7,
-        NFIT_CMD_ARS_INJECT_CLEAR = 8,
-        NFIT_CMD_ARS_INJECT_GET = 9,
+	NFIT_CMD_TRANSLATE_SPA = 5,
+	NFIT_CMD_ARS_INJECT_SET = 7,
+	NFIT_CMD_ARS_INJECT_CLEAR = 8,
+	NFIT_CMD_ARS_INJECT_GET = 9,
 };
 
 static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
@@ -2632,7 +2632,7 @@ static int acpi_nfit_blk_region_enable(struct nvdimm_bus *nvdimm_bus,
 	nfit_blk->bdw_offset = nfit_mem->bdw->offset;
 	mmio = &nfit_blk->mmio[BDW];
 	mmio->addr.base = devm_nvdimm_memremap(dev, nfit_mem->spa_bdw->address,
-                        nfit_mem->spa_bdw->length, nd_blk_memremap_flags(ndbr));
+			nfit_mem->spa_bdw->length, nd_blk_memremap_flags(ndbr));
 	if (!mmio->addr.base) {
 		dev_dbg(dev, "%s failed to map bdw\n",
 				nvdimm_name(nvdimm));
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index dea8a60e18a4..42db76905178 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -40,7 +40,7 @@ static inline char pin_name(int pin)
 }
 
 /* --------------------------------------------------------------------------
-                         PCI IRQ Routing Table (PRT) Support
+			 PCI IRQ Routing Table (PRT) Support
    -------------------------------------------------------------------------- */
 
 /* http://bugzilla.kernel.org/show_bug.cgi?id=4773 */
@@ -238,7 +238,7 @@ static int acpi_pci_irq_find_prt_entry(struct pci_dev *dev,
 }
 
 /* --------------------------------------------------------------------------
-                          PCI Interrupt Routing Support
+			  PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
 #ifdef CONFIG_X86_IO_APIC
 extern int noioapicquirk;
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 606da5d77ad3..8a79b72f1928 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -75,7 +75,7 @@ static DEFINE_MUTEX(acpi_link_lock);
 static int sci_irq = -1, sci_penalty;
 
 /* --------------------------------------------------------------------------
-                            PCI Link Device Management
+			    PCI Link Device Management
    -------------------------------------------------------------------------- */
 
 /*
@@ -390,7 +390,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 }
 
 /* --------------------------------------------------------------------------
-                            PCI Link IRQ Management
+			    PCI Link IRQ Management
    -------------------------------------------------------------------------- */
 
 /*
@@ -714,7 +714,7 @@ int acpi_pci_link_free_irq(acpi_handle handle)
 }
 
 /* --------------------------------------------------------------------------
-                                 Driver Interface
+				 Driver Interface
    -------------------------------------------------------------------------- */
 
 static int acpi_pci_link_add(struct acpi_device *device,
diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 7ddd57abadd1..95f23acd5b80 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -173,7 +173,7 @@ static int pci_mcfg_quirk_matches(struct mcfg_fixup *f, u16 segment,
 {
 	if (!memcmp(f->oem_id, mcfg_oem_id, ACPI_OEM_ID_SIZE) &&
 	    !memcmp(f->oem_table_id, mcfg_oem_table_id,
-	            ACPI_OEM_TABLE_ID_SIZE) &&
+		    ACPI_OEM_TABLE_ID_SIZE) &&
 	    f->oem_revision == mcfg_oem_revision &&
 	    f->segment == segment &&
 	    resource_contains(&f->bus_range, bus_range))
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 837b875d075e..0cb41bcda618 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -66,7 +66,7 @@ static LIST_HEAD(acpi_power_resource_list);
 static DEFINE_MUTEX(power_resource_list_lock);
 
 /* --------------------------------------------------------------------------
-                             Power Resource Management
+			     Power Resource Management
    -------------------------------------------------------------------------- */
 
 static inline
@@ -624,7 +624,7 @@ int acpi_power_wakeup_list_init(struct list_head *list, int *system_level_p)
 }
 
 /* --------------------------------------------------------------------------
-                             Device Power Management
+			     Device Power Management
    -------------------------------------------------------------------------- */
 
 /**
@@ -645,7 +645,7 @@ int acpi_power_wakeup_list_init(struct list_head *list, int *system_level_p)
  * -ENODEV if the execution of either _DSW or _PSW has failed
  */
 int acpi_device_sleep_wake(struct acpi_device *dev,
-                           int enable, int sleep_state, int dev_state)
+			   int enable, int sleep_state, int dev_state)
 {
 	union acpi_object in_arg[3];
 	struct acpi_object_list arg_list = { 3, in_arg };
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 5909e8fa4013..3b9c74498cd7 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -354,7 +354,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 				  (u32) px->control, (u32) px->status));
 
 		/*
- 		 * Check that ACPI's u64 MHz will be valid as u32 KHz in cpufreq
+		 * Check that ACPI's u64 MHz will be valid as u32 KHz in cpufreq
 		 */
 		if (!px->core_frequency ||
 		    ((u32)(px->core_frequency * 1000) !=
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index a0bd56ece3ff..68b9c22133fe 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -649,7 +649,7 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 }
 
 /* --------------------------------------------------------------------------
-                              Throttling Control
+			      Throttling Control
    -------------------------------------------------------------------------- */
 static int acpi_processor_get_throttling_fadt(struct acpi_processor *pr)
 {
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index f158b8c30113..437ff479c598 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -291,7 +291,7 @@ static const struct power_supply_desc acpi_sbs_charger_desc = {
 };
 
 /* --------------------------------------------------------------------------
-                            Smart Battery System Management
+			    Smart Battery System Management
    -------------------------------------------------------------------------- */
 
 struct acpi_battery_reader {
@@ -366,7 +366,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 					 state_readers[i].mode,
 					 ACPI_SBS_BATTERY,
 					 state_readers[i].command,
-				         (u8 *)battery +
+					 (u8 *)battery +
 						state_readers[i].offset);
 		if (result)
 			goto end;
@@ -469,7 +469,7 @@ static const struct device_attribute alarm_attr = {
 };
 
 /* --------------------------------------------------------------------------
-                                 Driver Interface
+				 Driver Interface
    -------------------------------------------------------------------------- */
 static int acpi_battery_read(struct acpi_battery *battery)
 {
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 87b74e9015e5..53c2862c4c75 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -176,7 +176,7 @@ int acpi_smbus_write(struct acpi_smb_hc *hc, u8 protocol, u8 address,
 EXPORT_SYMBOL_GPL(acpi_smbus_write);
 
 int acpi_smbus_register_callback(struct acpi_smb_hc *hc,
-			         smbus_alarm_callback callback, void *context)
+				 smbus_alarm_callback callback, void *context)
 {
 	mutex_lock(&hc->lock);
 	hc->callback = callback;
diff --git a/drivers/acpi/sbshc.h b/drivers/acpi/sbshc.h
index c3522bb82792..06ea16914aed 100644
--- a/drivers/acpi/sbshc.h
+++ b/drivers/acpi/sbshc.h
@@ -28,5 +28,5 @@ extern int acpi_smbus_read(struct acpi_smb_hc *hc, u8 protocol, u8 address,
 extern int acpi_smbus_write(struct acpi_smb_hc *hc, u8 protocol, u8 slave_address,
 		u8 command, u8 * data, u8 length);
 extern int acpi_smbus_register_callback(struct acpi_smb_hc *hc,
-			         smbus_alarm_callback callback, void *context);
+				 smbus_alarm_callback callback, void *context);
 extern int acpi_smbus_unregister_callback(struct acpi_smb_hc *hc);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a896e5e87c93..45060915334d 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -717,7 +717,7 @@ int acpi_device_add(struct acpi_device *device,
 }
 
 /* --------------------------------------------------------------------------
-                                 Device Enumeration
+				 Device Enumeration
    -------------------------------------------------------------------------- */
 static struct acpi_device *acpi_bus_get_parent(acpi_handle handle)
 {
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 12c0ece746f0..693547004035 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -177,7 +177,7 @@ struct acpi_thermal {
 };
 
 /* --------------------------------------------------------------------------
-                             Thermal Zone Management
+			     Thermal Zone Management
    -------------------------------------------------------------------------- */
 
 static int acpi_thermal_get_temperature(struct acpi_thermal *tz)
@@ -897,7 +897,7 @@ static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 
 
 /* --------------------------------------------------------------------------
-                                 Driver Interface
+				 Driver Interface
    -------------------------------------------------------------------------- */
 
 static void acpi_thermal_notify(struct acpi_device *device, u32 event)
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index d5411a166685..d2f5d5048355 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -22,7 +22,7 @@
 ACPI_MODULE_NAME("utils");
 
 /* --------------------------------------------------------------------------
-                            Object Evaluation Helpers
+			    Object Evaluation Helpers
    -------------------------------------------------------------------------- */
 static void
 acpi_util_eval_error(acpi_handle h, acpi_string p, acpi_status s)
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 3a032afd9d05..4f5463b2a217 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -178,14 +178,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
 		},
 	},
-        {
-         .callback = video_detect_force_video,
-         .ident = "ThinkPad X201T",
-         .matches = {
-                DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-                DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201T"),
-                },
-        },
+	{
+	 .callback = video_detect_force_video,
+	 .ident = "ThinkPad X201T",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201T"),
+		},
+	},
 
 	/* The native backlight controls do not work on some older machines */
 	{
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index f89dd9a99e6e..e8c59578598f 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -44,7 +44,7 @@ void acpi_enable_wakeup_devices(u8 sleep_state)
 		if (!dev->wakeup.flags.valid
 		    || sleep_state > (u32) dev->wakeup.sleep_state
 		    || !(device_may_wakeup(&dev->dev)
-		        || dev->wakeup.prepare_count))
+			|| dev->wakeup.prepare_count))
 			continue;
 
 		if (device_may_wakeup(&dev->dev))
@@ -69,7 +69,7 @@ void acpi_disable_wakeup_devices(u8 sleep_state)
 		if (!dev->wakeup.flags.valid
 		    || sleep_state > (u32) dev->wakeup.sleep_state
 		    || !(device_may_wakeup(&dev->dev)
-		        || dev->wakeup.prepare_count))
+			|| dev->wakeup.prepare_count))
 			continue;
 
 		acpi_set_gpe_wake_mask(dev->wakeup.gpe_device, dev->wakeup.gpe_number,


