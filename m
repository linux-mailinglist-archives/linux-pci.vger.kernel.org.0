Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87204E15B4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 11:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390851AbfJWJZ5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Oct 2019 05:25:57 -0400
Received: from mail-oln040092255088.outbound.protection.outlook.com ([40.92.255.88]:6254
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732648AbfJWJZ5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 05:25:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7KScMhRzsLlZyVHB9RJRIDpg440yffxR7VFHafzbYrOikh8KvA/7WGJpnTGz5bJI+ygoR1AxEozD0ah4OSanoerLptrT526rbZr4hZbChukqvX10wxryJ58xIrvtW6pHiqR3N3SUG60u9kCks8rSgT8Z3NSOlZOpTCGJ9DmbTVgDQfRLdRJ5+x+qwtZEYjkCwGoF6/Jpa2eqsCby3gA3tAe5VdYj+9wkk4e6G6oSvF4CfFLe0gjKU0dpoTTLwefEHbHTEA7RlMBm/iLLBuE21f+Tri0wgYJxO1Y/ypf/aXmOlRSOah+0ScnpLAs/WtKw5YXW2X6Xa4GxAExv7RPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shgW0n/4AmciX2HElcdqZEP8/63gMwtcPi0hWmzWoGs=;
 b=R7Gg/QEXGlbh5Ly2dPaM263Z5ZO9VnFMKXEn6b6fG99apKq0SPKmAKFzzWlEXYLhGZyW/7R4yeY05OkVADB8Z3vJmkiB3oyGB4OfhkDWBbuiiDtFgqP+fsP/p6coOpjbj15ZKk+Di5LWLbuISNME73NMbI3OHxld38KaPnBl2cO0V5Nc+u/62+2DuTqsn7M3ktPLnhfKJIuBe3MNldFaJwPem/bc34+OCwjqgTCn+US/vOWUqqNMvdRbWE8OEB5m9oV97cjnMr6FG0b9Ud/TcOGxJr8krLbrMTUwgKXguNIgpxMmS9gURluYCtpfT7ptrjRRQ97s8MzaVHWw166LEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT024.eop-APC01.prod.protection.outlook.com
 (10.152.252.52) by PU1APC01HT163.eop-APC01.prod.protection.outlook.com
 (10.152.252.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.14; Wed, 23 Oct
 2019 09:25:46 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.52) by
 PU1APC01FT024.mail.protection.outlook.com (10.152.252.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14 via Frontend Transport; Wed, 23 Oct 2019 09:25:46 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 09:25:46 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v8 5/6] PCI: Add hp_mmio_size and hp_mmio_pref_size
 parameters
Thread-Topic: [PATCH v8 5/6] PCI: Add hp_mmio_size and hp_mmio_pref_size
 parameters
Thread-Index: AQHVQ7FMspRm/nOOq06+h4K2TYRXf6dRHQOAgBdjQoA=
Date:   Wed, 23 Oct 2019 09:25:46 +0000
Message-ID: <SL2P216MB01877D567507333F37629C2D806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB0187C45A8B38504D855A1DEA80C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20191008121623.GJ2819@lahna.fi.intel.com>
In-Reply-To: <20191008121623.GJ2819@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME3P282CA0001.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:80::11) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:C52107058565CC9F4E1233773ACED8CA5B68DA1B723A5DC5AF2D9D8B4CAD4D76;UpperCasedChecksum:7916CE3D624F6A785A29099226A51810EC453E73A119FEF930EA08F7D670CC17;SizeAsReceived:7657;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [BKd22+ZetwQwUkES8ykQEHZfO2oLPg2e]
x-microsoft-original-message-id: <20191023092537.GC4080@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT163:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: reKtD1ejwavrb1BZjFeB5EqmrU1d/RkNbpbNeG7EtDiOzSCZtwEEcOLiYRLTOfDGZO9N+/RD/BzsyL8Na1t7x7cDKfhXvKRnWvPaDdIUr6xBKfRMXtMmAQMtaxyAvYAApL4mO19W0sj52zwLBy5LM8u7BX8YnGWN3JAMmXyuNdxt9MItGw9bygcN7q/lFBTQ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C99FA2B92415B47BE95E07B2E426B01@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 895ef4dc-c0d7-4fc6-a024-08d7579afbd1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 09:25:46.2801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT163
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 08, 2019 at 03:16:23PM +0300, mika.westerberg@linux.intel.com wrote:
> On Fri, Jul 26, 2019 at 12:54:44PM +0000, Nicholas Johnson wrote:
> > Add kernel parameter pci=hpmmiosize=nn[KMG] to set MMIO bridge window
> > size for hotplug bridges.
> > 
> > Add kernel parameter pci=hpmmioprefsize=nn[KMG] to set MMIO_PREF bridge
> > window size for hotplug bridges.
> > 
> > Leave pci=hpmemsize=nn[KMG] unchanged, to prevent disruptions to
> > existing users. This sets both MMIO and MMIO_PREF to the same size.
> > 
> > The two new parameters conform to the style of pci=hpiosize=nn[KMG].
> > 
> > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> 
> This does not apply anymore because of 003d3b2c5f83 ("PCI: Make
> pci_hotplug_io_size, mem_size, and bus_size private") so I think you
> need to rebase this on top of current mainline.
Yes, that was the first thing I noticed when doing Linux 5.4. Despite 
not posting straight away, I did compile straight away. I did just 
re-post this patch on its own (breaking away from the series).

It is nice how I no longer need to modify anything outside of 
drivers/pci and Documentation/ directories because of 003d3b2c5f83, 
which may make it easier to get signed off. It also means that 
re-applying the patch no longer triggers a full kernel recompile.

I should have read the following advice first, but I will make changes 
and re-post.

> 
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  9 ++++++-
> >  drivers/pci/pci.c                             | 17 ++++++++++---
> >  drivers/pci/setup-bus.c                       | 25 +++++++++++--------
> >  include/linux/pci.h                           |  3 ++-
> >  4 files changed, 38 insertions(+), 16 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 46b826fcb..9bc54cb99 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3467,8 +3467,15 @@
> >  		hpiosize=nn[KMG]	The fixed amount of bus space which is
> >  				reserved for hotplug bridge's IO window.
> >  				Default size is 256 bytes.
> > +		hpmmiosize=nn[KMG]	The fixed amount of bus space which is
> > +				reserved for hotplug bridge's MMIO window.
> > +				Default size is 2 megabytes.
> > +		hpmmioprefsize=nn[KMG]	The fixed amount of bus space which is
> > +				reserved for hotplug bridge's MMIO_PREF window.
> > +				Default size is 2 megabytes.
> >  		hpmemsize=nn[KMG]	The fixed amount of bus space which is
> > -				reserved for hotplug bridge's memory window.
> > +				reserved for hotplug bridge's MMIO and
> > +				MMIO_PREF window.
> >  				Default size is 2 megabytes.
> >  		hpbussize=nn	The minimum amount of additional bus numbers
> >  				reserved for buses below a hotplug bridge.
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 29ed5ec1a..6b3857cad 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -85,10 +85,12 @@ unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
> >  unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
> >  
> >  #define DEFAULT_HOTPLUG_IO_SIZE		(256)
> > -#define DEFAULT_HOTPLUG_MEM_SIZE	(2*1024*1024)
> > +#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
> > +#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
> >  /* pci=hpmemsize=nnM,hpiosize=nn can override this */
> >  unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
> > -unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
> > +unsigned long pci_hotplug_mmio_size = DEFAULT_HOTPLUG_MMIO_SIZE;
> > +unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
> >  
> >  #define DEFAULT_HOTPLUG_BUS_SIZE	1
> >  unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
> > @@ -6281,8 +6283,17 @@ static int __init pci_setup(char *str)
> >  				pcie_ecrc_get_policy(str + 5);
> >  			} else if (!strncmp(str, "hpiosize=", 9)) {
> >  				pci_hotplug_io_size = memparse(str + 9, &str);
> > +			} else if (!strncmp(str, "hpmmiosize=", 11)) {
> > +				pci_hotplug_mmio_size =
> > +					memparse(str + 11, &str);
> 
> I would keep this in single line disregarding the 80 char limit.
> 
> > +			} else if (!strncmp(str, "hpmmioprefsize=", 15)) {
> > +				pci_hotplug_mmio_pref_size =
> > +					memparse(str + 15, &str);
> 
> Ditto
> 
> >  			} else if (!strncmp(str, "hpmemsize=", 10)) {
> > -				pci_hotplug_mem_size = memparse(str + 10, &str);
> > +				pci_hotplug_mmio_size =
> > +					memparse(str + 10, &str);
> Ditto.
> 
> > +				pci_hotplug_mmio_pref_size =
> > +					memparse(str + 10, &str);
> 
> Ditto.
> 
> >  			} else if (!strncmp(str, "hpbussize=", 10)) {
> >  				pci_hotplug_bus_size =
> >  					simple_strtoul(str + 10, &str, 0);
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 7e1dc892a..345ecf16d 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1178,7 +1178,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
> >  {
> >  	struct pci_dev *dev;
> >  	unsigned long mask, prefmask, type2 = 0, type3 = 0;
> > -	resource_size_t additional_mem_size = 0, additional_io_size = 0;
> > +	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
> > +		additional_mmio_pref_size = 0;
> 
> Maybe align them like
> 
> 	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
> 			additional_mmio_pref_size = 0;
> 
> >  	struct resource *b_res;
> >  	int ret;
> >  
> > @@ -1212,7 +1213,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
> >  		pci_bridge_check_ranges(bus);
> >  		if (bus->self->is_hotplug_bridge) {
> >  			additional_io_size  = pci_hotplug_io_size;
> > -			additional_mem_size = pci_hotplug_mem_size;
> > +			additional_mmio_size = pci_hotplug_mmio_size;
> > +			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
> >  		}
> >  		/* Fall through */
> >  	default:
> > @@ -1230,9 +1232,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
> >  		if (b_res[2].flags & IORESOURCE_MEM_64) {
> >  			prefmask |= IORESOURCE_MEM_64;
> >  			ret = pbus_size_mem(bus, prefmask, prefmask,
> > -				  prefmask, prefmask,
> > -				  realloc_head ? 0 : additional_mem_size,
> > -				  additional_mem_size, realloc_head);
> > +				prefmask, prefmask,
> > +				realloc_head ? 0 : additional_mmio_pref_size,
> > +				additional_mmio_pref_size, realloc_head);
> >  
> >  			/*
> >  			 * If successful, all non-prefetchable resources
> > @@ -1254,9 +1256,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
> >  		if (!type2) {
> >  			prefmask &= ~IORESOURCE_MEM_64;
> >  			ret = pbus_size_mem(bus, prefmask, prefmask,
> > -					 prefmask, prefmask,
> > -					 realloc_head ? 0 : additional_mem_size,
> > -					 additional_mem_size, realloc_head);
> > +				prefmask, prefmask,
> > +				realloc_head ? 0 : additional_mmio_pref_size,
> > +				additional_mmio_pref_size, realloc_head);
> >  
> >  			/*
> >  			 * If successful, only non-prefetchable resources
> > @@ -1265,7 +1267,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
> >  			if (ret == 0)
> >  				mask = prefmask;
> >  			else
> > -				additional_mem_size += additional_mem_size;
> > +				additional_mmio_size +=
> > +					additional_mmio_pref_size;
> 
> Here also looks better if you put them single line.
> 
> >  
> >  			type2 = type3 = IORESOURCE_MEM;
> >  		}
> > @@ -1285,8 +1288,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
> >  		 * prefetchable resource in a 64-bit prefetchable window.
> >  		 */
> >  		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
> > -				realloc_head ? 0 : additional_mem_size,
> > -				additional_mem_size, realloc_head);
> > +			realloc_head ? 0 : additional_mmio_size,
> > +			additional_mmio_size, realloc_head);
> >  		break;
> >  	}
> >  }
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 9e700d9f9..1bde5763a 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -2031,7 +2031,8 @@ extern u8 pci_dfl_cache_line_size;
> >  extern u8 pci_cache_line_size;
> >  
> >  extern unsigned long pci_hotplug_io_size;
> > -extern unsigned long pci_hotplug_mem_size;
> > +extern unsigned long pci_hotplug_mmio_size;
> > +extern unsigned long pci_hotplug_mmio_pref_size;
> >  extern unsigned long pci_hotplug_bus_size;
> >  
> >  /* Architecture-specific versions may override these (weak) */
> > -- 
> > 2.22.0

Okay, so basically alignment and ignore the 80-character rule in a heap 
of cases. That seems easy enough.

Thanks for reviewing.
