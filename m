Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88ED5123C01
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 01:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfLRAyb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 17 Dec 2019 19:54:31 -0500
Received: from mail-oln040092255076.outbound.protection.outlook.com ([40.92.255.76]:20804
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfLRAyb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 19:54:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/9EcKx4H3uGIf3cRLij4BXKuAcrl7VvprkHfBeCEb8k28dlbYE7LoMxM1mFQiqUcEXd61inesy5EmllOKIyowuyiqd0x8180G0Rte56ast43v/3Yjb/kWJuz33Tv5cG1T45wdWzlgCG5xNBNN5d+3Ra+HOTu74hFvsPotsuAdAX1Jj3Rp0eZ16VZiK1BkvCwXEUsI/yCxF6zjuIDI/uJYsgJcJlohZSDtaxiXmU8P3gDUnpSphf308B9nNnsqYDkY887kBprDJsOj/fiFLS5SQJjGgkArpcDZYUtky6UweFn2IWUk2bDWWCr9zMNI3nFvF1tcINrcGnZEuTbW8LSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4GNSnYSXrLt5tmKHC1uoGa3lrkchQjIEmP3ezPAiDY=;
 b=M+yWsEj8XIeUzQ8kfzHsDWAhGuCMX3HOG+RkxLbj/+dRhruNn3h4ZGlAmsw/HrMMXymfaPW4eq/YrycAs7wvmXKsbLiA+Bp9K0LMN+W13pEhAlB9x9OXjtQPCeynoIslv0gHoMl0gFl5UTQuLfAxYq1wq3mlPsLnWgooAjfdTXKQpGP0yHMGfjpjPHJMEYuGrF3xBKTgW8nTcBfvzo1JLbCGA12qSGGZVZYvCsh0JkeC34aJmxQ68mKsxg1YGUNTZZbdPlhOAsCMQdJBce6qnGYCNIs6rEdD48M9BcRDEi9pbNy3oSQr3IM/RyWM+cpS6vDUtNaouR8UNGMSmFnXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT024.eop-APC01.prod.protection.outlook.com
 (10.152.248.57) by HK2APC01HT081.eop-APC01.prod.protection.outlook.com
 (10.152.249.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Wed, 18 Dec
 2019 00:54:25 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.59) by
 HK2APC01FT024.mail.protection.outlook.com (10.152.248.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Wed, 18 Dec 2019 00:54:25 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2559.012; Wed, 18 Dec
 2019 00:54:25 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Thread-Topic: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Thread-Index: AQHVrpB+5sK/XGeQw0yttw28ATWBvae+e8EAgACidQA=
Date:   Wed, 18 Dec 2019 00:54:25 +0000
Message-ID: <PSXP216MB043840E2DE9B81AC8797F63A80530@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB043892C04178AB333F7AF08C80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191217151248.GA165530@google.com>
In-Reply-To: <20191217151248.GA165530@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0212.ausprd01.prod.outlook.com
 (2603:10c6:10:16::32) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:0103C68B7F466E5D81778545F90EC545737357BD511B6FF8A4AAA33DF3C67C61;UpperCasedChecksum:849F45C591BDD9E4928D99B1FFEF4523566D3CFF53E75C5D891F6B48310BCF47;SizeAsReceived:7720;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [7nh6eMByoR5qNMW7hY1cjIaamaWpdvZEaMAnU1Rcbdp0Kk+fCl7bwuB2yc6FZ4tgDyDlXYvqHIk=]
x-microsoft-original-message-id: <20191218005416.GA1608@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 16d5551a-7281-4382-0aeb-08d78354d36f
x-ms-traffictypediagnostic: HK2APC01HT081:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XCKE3wxgSnFbfdULOI7Xu3WizwApEa0y+nQgyaa3W5g7DKKtC6/ZGpzi5mHVTWET2b5bF0n0CiArxNssnXADMAIQRLuesVi2l/9/nzvZ9CvyG+RzIhOjKMFdQn0qyT0xA+DWWkdI78tZn/oNruEMfhk2lcizmja4gBycVYbJ1r9RPRGTE3VTg9Oz6Fvjjk0H
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <66CD41A32A2343429139866934B382AA@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d5551a-7281-4382-0aeb-08d78354d36f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 00:54:25.0373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT081
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 17, 2019 at 09:12:48AM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 09, 2019 at 12:59:29PM +0000, Nicholas Johnson wrote:
> > Hi all,
> > 
> > Since last time:
> > 	Reverse Christmas tree for a couple of variables
> > 
> > 	Changed while to whilst (sounds more formal, and so that 
> > 	grepping for "while" only brings up code)
> > 
> > 	Made sure they still apply to latest Linux v5.5-rc1
> > 
> > Kind regards,
> > Nicholas
> > 
> > Nicholas Johnson (4):
> >   PCI: Consider alignment of hot-added bridges when distributing
> >     available resources
> >   PCI: In extend_bridge_window() change available to new_size
> >   PCI: Change extend_bridge_window() to set resource size directly
> >   PCI: Allow extend_bridge_window() to shrink resource if necessary
> 
> I have tentatively applied these to pci/resource for v5.6, but I need
> some kind of high-level description for why we want these changes.
I could not find these in linux-next (whereas it was almost immediate 
last time), so this must be why.

> 
> The commit logs describe what the code does, and that's good, but we
> really need a little more of the *why* and what the user-visible
> benefit is.  I know some of this was in earlier postings, but it seems
> to have gotten lost along the way.
Is this explanation going into the commit notes, or is this just to get 
it past reviewers, Greg K-H and Linus Torvalds?

Here is an attempt:

Although Thunderbolt 3 does not need special treatment like Cardbus, it 
does require the kernel to be up to date with PCI hotplug and capable of 
assigning resources when native enumeration mode is used (as opposed to 
BIOS-assisted mode). Operating systems have neglected this over the 
years, as PCI hotplug is not widely used.

Thunderbolt has a structure where each downstream facing port is a PCI 
hotplug bridge. Peripheral devices may have a second Thunderbolt port 
for daisy chaining more devices, much like Firewire did.

In this example, the controller is at bus 03, and this controller has 
two ports. Bus 05 is the NHI (Native Host Interface) and Bus 39 is the 
USB controller. Bus 07 is a Thunderbolt dock, as is Bus 0d, daisy 
chained after the first dock. The hotplug bridges are 04.01, 04.04, 
07.04, 0d.04, and depending on the implementation, 1c.4 under the host 
controller.

+-1c.4-[03-6c]----00.0-[04-6c]--+-00.0-[05]----00.0
|                               +-01.0-[06-38]----00.0-[07-38]--+-00.0-[08]----00.0
|                               |                               +-01.0-[09]----00.0
|                               |                               +-02.0-[0a]--
|                               |                               +-03.0-[0b]--
|                               |                               \-04.0-[0c-38]----00.0-[0d-38]--+-00.0-[0e]----00.0
|                               |                                                               +-01.0-[0f]----00.0
|                               |                                                               +-02.0-[10]--
|                               |                                                               +-03.0-[11]--
|                               |                                                               \-04.0-[12-38]--
|                               +-02.0-[39]----00.0
|                               \-04.0-[3a-6c]--

The host controller implementation appears differently in new Intel Ice 
Lake systems, with the Thunderbolt controllers integrated into the CPU, 
with the Thunderbolt ports appearing as chipset root ports.

Ice Lake with 2/4 Thunderbolt 3 ports implemented (0d.0 is the USB 
controller and 0d.2 is NHI #0):

-[0000:00]-+-00.0
           +-02.0
           +-04.0
           +-07.0-[01-2b]--
           +-07.1-[2c-56]--
           +-0d.0
           +-0d.2

Thunderbolt is unusual in that we have nested hotplug bridges. Mika 
Westerberg <mika.westerberg@linux.intel.com> has done most of the work 
required to assign all unused resources (busn and mem) from the parent 
bridge window to the downstream hotplug bridge, allowing for more 
Thunderbolt devices to be daisy-chained. However, in 
drivers/pci/setup-bus.c in pci_bus_distribute_available_resources(), I 
noticed problems with hot-adding Thunderbolt devices containing PCI 
devices with resource alignment above the minimum 1M. Furthermore, I 
found it more reliable to cease the use of additional size resource 
lists, which are considered "optional" when allocating. The operation of 
pci_bus_distribute_available_resources() is only as guaranteed as the 
resource assignment. None of this would work with resources assigned by 
the kernel parameters 
pci=hpmmiosize=nn[KMG],hpmmiosize=nn[KMG],hpmmioprefsize=nn[KMG] - it 
would only work if the resources under the root port were assigned by 
firmware.

I have solved the alignment problem with patch 1/4 in 
pci_bus_distribute_available_resources() and the remaining issues with 
patches 2-4 by changing extend_bridge_window() which is now named 
adjust_bridge_window(). You can find the link to the bug report filed by 
Mika Westerberg in patch 1/4 commit log.

To sum up, although this could be applicable to any hypothetical 
application with nested PCI hotplug bridges, the intended end user 
facing case is Thunderbolt 3 with native enumeration mode. My changes:
- Allow for hot-adding PCI devices with >1M alignment of BARs
- Offer improved resilience and reliability due to removal of add_size
- Allow this to work with resources assigned with the kernel parameters
  pci=hpmmiosize=nn[KMG],hpmmiosize=nn[KMG],hpmmioprefsize=nn[KMG] as 
  opposed to only firmware-allocated resources.



Please let me know if this is not adequate for the required purposes.

Thanks!

Kind regards,
Nicholas Johnson

> 
> Bjorn
