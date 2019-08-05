Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7132281EFE
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 16:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfHEOZT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 5 Aug 2019 10:25:19 -0400
Received: from mail-oln040092253103.outbound.protection.outlook.com ([40.92.253.103]:15536
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728918AbfHEOZS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 10:25:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtS6/iabta3neRuyCj+cdyjvLYWg9lP8VvXGyvi5ATfDa6fe7O1a05juGEh1sjjfmmDESuajvjBhqyL+o/KdEOcUG5YpFMb9FEk1atfX3R2d3heqzoloa7FQ/U3csvBE+HWfVHlQoT8iEKdsuPD8B7J2fGwJNZZKmOrDWma/E9yC10Wh5XzCcJRhSiWcmlXREE4RRhnb6WC8uZO5y44w01n/tQ5mcxL6OX297nLm/1AxEQ90qwe0JF8mW2lnkwmS5IxIzmLPCFFt52/W2MXoN7K7NE7gQTm81BKVpSFm4rtVlxCB2VJu8UVfJ9CpUi2Rw1zuUiQmgnAyYlXUT8LXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT6RDrd4SB0m5KjoAoYFG6yowC5Vfxo3v3gsro7AYMU=;
 b=RcvkbtbvCdi1QPvMIOwfsM3/cgnaes5aWEhzjKCANFazJ+4QGP9jeu03LAR6/S223gODdNrP+OLBSIa3UqDqMIQORtQZtx0EXLf6rpoV/hF8p38yDCIehMS+v2vs7QGI5LhLf+9uBTcMvETGlXQsJTrISHDfi7TMPaCVlm3cb29iB8Wp4lJUOjYXMvZ3yHxguRLoM1cu0xKQJBpSHeU1dMpEq0adVXEeWmA9IU5gRmD5K4m7Y3NVRxPmKJgddHcvRk+3Eu3P4CinmzBvbuopO5VNdXc1pNfy6ud5BPlszBAIqVe2mzTpaBSXitp8aNeGSufpgjt2JNVtVjmgpJ721w==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from PU1APC01FT059.eop-APC01.prod.protection.outlook.com
 (10.152.252.59) by PU1APC01HT194.eop-APC01.prod.protection.outlook.com
 (10.152.253.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.14; Mon, 5 Aug
 2019 14:25:13 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.56) by
 PU1APC01FT059.mail.protection.outlook.com (10.152.253.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14 via Frontend Transport; Mon, 5 Aug 2019 14:25:13 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::944c:1ec0:2a91:f222]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::944c:1ec0:2a91:f222%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 14:25:13 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Possible PCI Regression Linux 5.3-rc1
Thread-Topic: Possible PCI Regression Linux 5.3-rc1
Thread-Index: AQHVQh7cG4T+gPWoEEORs36yrE7T46bZxdcAgAGMzQCAACqSAIAPQRMAgAHR0gCAAB7NgA==
Date:   Mon, 5 Aug 2019 14:25:12 +0000
Message-ID: <SL2P216MB018734CFB47FB03F1578A7E780DA0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20190724133814.GA194025@google.com>
 <SL2P216MB0187E2042E5DB8D9F29E665280C10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <4f5afb8e-9013-980f-0553-c687d17ed8d5@deltatee.com>
 <SL2P216MB018719A03F048FFA0F745FED80DB0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20190805123450.GM2640@lahna.fi.intel.com>
In-Reply-To: <20190805123450.GM2640@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYXPR01CA0081.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::14) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:CD4B6FC40EC83471AF190902B4ACEF9A962F7A230853EB45D7F5E27E3DF3A9E1;UpperCasedChecksum:9266D6EE45FC947F12645C23D2C63DB5A5B76E44F236F61831235BA8DB8ACF50;SizeAsReceived:8041;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [VHzCmhMxT7YBL3AfzdXYVMn5WW9Ysrxip6dcLQynSKo9KSXRfhEwgoX8N+FIxgVMmncWXa4btJw=]
x-microsoft-original-message-id: <20190805142503.GA1957@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT194;
x-ms-traffictypediagnostic: PU1APC01HT194:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-message-info: rq7gUlcsHDIURmtwAl1FUWa9u51UttQlCiqEpEMLTxO3WeBWbn5j/IrNM/nIcKz4Wfsj9MohEAn/RLCABsO2pKRJ6ErDnJlgRP//8ed/+LyGxZOJWTahIVqPMuKuyeEzgxraddEPB+h/RviRsrsu5hXml3h6CrrmQOzp3mOxehPVgXvmk6tTLIfGMJ4oYCpZ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12D8E02966B56A46B0E2CC21EC94A2E1@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b070659-5042-4b49-1bcb-08d719b0ba41
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 14:25:12.9660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT194
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 05, 2019 at 03:34:50PM +0300, Mika Westerberg wrote:
> Hi,
> 
> On Sun, Aug 04, 2019 at 08:47:43AM +0000, Nicholas Johnson wrote:
> > Reversing the following commit solves the issue:
> > 
> > commit c2bf1fc212f7e6f25ace1af8f0b3ac061ea48ba5
> > Author: Mika Westerberg <mika.westerberg@linux.intel.com>
> > PCI: Add missing link delays required by the PCIe spec
> > 
> > Mika, care to weigh in (assuming you are back from four weeks leave)? 
> 
> I'm back now.
> 
> > Clearly this creates delays in "lspci -vt" in some Thunderbolt systems, 
> > but not all - otherwise you would have caught it. You mentioned Ice Lake 
> > in the commit log so perhaps it works fine on Ice Lake.
> 
> I also tried it on other systems but it may be that something is
> missing. Can you add "pciepordrv.dyndbg" to the kernel command line (or
> change the dev_dbg() in wait_for_downstream_link() to dev_info() instead
> and attach the dmesg along with full 'sudo lspci -vv' output to the
> following bugzilla (as I think they are the same issue in the end):
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=204413
> 
> Thanks!

Done. Please note the update I sent to my own email with more 
information, elaborating that it is reading the config from under the 
NHI which causes the delay. If bus 05 is under the NHI, then the 
following command has a delay:

$ cat /sys/bus/pci/devices/0000\:05\:00.0/config

Whereas reading config from all the other busses is fine. This is what 
is holding up the lspci command.

If possible, please look over my patches briefly to catch any silly 
mistakes or trivial changes to get stuff out of the way for thorough 
review later. I really want to at least get the alignment patch in which 
will help Linux with native enumeration and solve your bug report.

Thanks!

Regards,
Nicholas.
