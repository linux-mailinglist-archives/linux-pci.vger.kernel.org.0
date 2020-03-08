Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B2217D1F0
	for <lists+linux-pci@lfdr.de>; Sun,  8 Mar 2020 06:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgCHFvU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 8 Mar 2020 00:51:20 -0500
Received: from mail-oln040092254040.outbound.protection.outlook.com ([40.92.254.40]:24944
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbgCHFvU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 8 Mar 2020 00:51:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0RMCzJ08xlb6IowY5vtA4cKadiFuFBYpZFN432R6qNg28sHhSGbdZA6Gp1wG5hmlfUT0eBbaJzWEQVzDgpET6CRutpmlgSbMAvrGs/W9INBQTL6Hv6PgDeB50Dp92MP95jai9seFl4Yq+BEEpTnpjrVyy5ICyHjuiP7XZ0Fz2v83EZNHl/WQUP+1FL/3XosJyAARaaZtOAB5JREvPEpAKKIGKW8bktOkAGc8L0ZbMKkGZuQtMj3Mx9/Oupe8sm4Cz1A73LwZrzwuMOi1UrzOabDY6x/6rF+E87ke0ot4uaJEl5hTzy2ArGWGc3P2V4ZcMLr67C/z6uVFGmeF0jz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCZIqMvJ9AIxz6iKpFb+m1B3DnMG1kJ68TSHXJjlgVc=;
 b=ODaUUQC8xNVICHsh2AIShGeqhgqJtPbWxl6N1IMXPjIPQekBGdHjnIoGoFB7hZNvMJ7zTm6fExrmMtC+qhTxwlv6qzYjVYhVbhicfuDg8lfUF3ilnFjjiOLJhew7NuGT64g4i/WPVZ3JJR4oSlmLoMd5kKOHG2yWsO8rOgCSbfyZbpnoA8S3H787p0Xk9/avwSe66z2z9eoijmQEseyvfd3s+WX3lOMqedOo36oT85AMEGvXb339cmU8357gswzKekQy+nYubmtP93fAEFu79A/+yOv5AmPX+dn9gAFOrLCJ6kAXRLMoG8QBFvh1Pzv+buc32igytTgjelQI5/1hEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT042.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::38) by
 SG2APC01HT012.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::213)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Sun, 8 Mar
 2020 05:51:15 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.51) by
 SG2APC01FT042.mail.protection.outlook.com (10.152.251.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Sun, 8 Mar 2020 05:51:15 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2793.013; Sun, 8 Mar 2020
 05:51:15 +0000
Received: from nicholas-dell-linux (2001:44b8:605f:11:6375:33df:328c:d925) by MEAPR01CA0036.ausprd01.prod.outlook.com (2603:10c6:201::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend Transport; Sun, 8 Mar 2020 05:51:13 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     =?iso-8859-1?Q?Lu=EDs_Mendes?= <luis.p.mendes@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on
 Linux
Thread-Topic: Problem with PCIe enumeration of Google/Coral TPU Edge module on
 Linux
Thread-Index: AQHV9ADoyzr1FzCb40+Hnw+tD7TMTKg9CxYAgAA2i4CAAGf1gIAAiYYA
Date:   Sun, 8 Mar 2020 05:51:15 +0000
Message-ID: <PSXP216MB04382D268822AD1C3D9A57C780E10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <CAEzXK1oukcnjgkY8Y6rkHcBAKwSvTDJsJVCf7nix4eoPPFsNqg@mail.gmail.com>
 <20200307213853.GA208095@google.com>
In-Reply-To: <20200307213853.GA208095@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEAPR01CA0036.ausprd01.prod.outlook.com (2603:10c6:201::24)
 To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:30CCFDE5AF84E386076D929E87157DDEAC41B98066E20B2D9B47DEFFCA4F0E96;UpperCasedChecksum:202F98E55639649378129A8166832D2EAB92E58D714A613F1F96A47CA46AA052;SizeAsReceived:7964;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [+MNZiwBfwmLSXpIyPoSeysq4imRbYO5z+LGGiSXnGg7Ao39gjDdwvTUqPcmLKjJy]
x-microsoft-original-message-id: <20200308055106.GA3897@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f272a69c-e447-48ee-a078-08d7c324b6b2
x-ms-traffictypediagnostic: SG2APC01HT012:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ex/tL8we8Hxq0wATIyh0nsth5z+3Nef5qH3dNg6i2m1i6Cpr4y19V4KCU+O5U27QUbSShSVbDhCvpIYNxg4dA+TpUtrJbzxQjblG2gS8Mu8KdkoOpIbK51AE5eaGTN4n7n9JUtxOMOwEt8zqZ2AXe2RNTveXq3MIan+IC7jCo4wzTigwF3BogTpVMmFKFkC2
x-ms-exchange-antispam-messagedata: Z8497FmibK+/F+IO4fSfG109fThccCx3yvXOWj1y11p0gSSQ/TuHHl8NnN7r3noUtW3DxWDoiXoXkc4l9Lx+HaAO0cZudeKsvny4G909HL2hujfYc6q39dytWItiPaj3h0fdSxKXhXbFy1orG5FNJ3IJT++3Cp291fOYmUkdIj5Jte/p9cP/O5sBmaqQPORgFc9mtbZrHCs78QUVfDpVnA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <81A2855E68486C4FA7671F4D3525D507@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f272a69c-e447-48ee-a078-08d7c324b6b2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2020 05:51:15.1621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT012
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
> > On Sat, Mar 7, 2020 at 12:11 PM Luís Mendes <luis.p.mendes@gmail.com> wrote:
> > > This issue seems to happen only with the Coral Edge TPU device, but it
> > > happens independently of whether the gasket/apex driver module is
> > > loaded or not. The BAR 0 of the Coral device is not assigned either
> > > way.
> > >
> > > Luís

So the problem only occurs with the Coral Edge TPU device, so there is a 
possibility that it is not a problem with the platform, or something 
caused by the combination of the TPU and platform. Is it possible to put 
the TPU into an X86 system with the same kernel version(s) to add more 
evidence to this theory? If it works on X86 then we can focus on the 
differences between X86 and ARM.

Also, please revert c13704f5685d "PCI: Avoid double hpmemsize MMIO 
window assignment" or try with Linux v5.4 which does not have this 
commit, just to rule out the possibility of it causing issues. This 
patch helps me and also solved the problem of one other person using an 
ARM computer who came to us regarding a problem. However, it could also 
adversely affect unknown use cases - it is impossible to completely rule 
out, due to the nature of how drivers/pci/setup-bus.c is written.

Kind regards,
Nicholas
