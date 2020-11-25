Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB5C2C3A4B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 08:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgKYHtk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 02:49:40 -0500
Received: from mx0a-00300601.pphosted.com ([148.163.146.64]:1782 "EHLO
        mx0a-00300601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726407AbgKYHtk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 02:49:40 -0500
X-Greylist: delayed 6139 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2020 02:49:36 EST
Received: from pps.filterd (m0142706.ppops.net [127.0.0.1])
        by mx0b-00300601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AP5xY3b193499;
        Wed, 25 Nov 2020 06:05:07 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0b-00300601.pphosted.com with ESMTP id 351hkpg2c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 06:05:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhdQ0RALWLWeeD9ou3EhNA+KgfchOQHXHhEYIxUUbFxMShWrCIqIwm0vM9vVossDEuXj3HCGl4mtsrHdqrH6kkXMYQhn36ZXNutCcTLLIsp3XVSMFQoQw8vWO3DIynMYomvpPJklOG2S6iMCTGeY5iW9qIBlpYdMnbvWjaNnPEUt3JeBPEjqa2cE44TiVyD5bTPS/l5d9GhNxYPDgJ4wCM948R589iq7+dBYJi+pwoeQ+3k5zieKtwH4EJ1jp1N07Vc3Ld4BfUWNcpqEZn9HtGypDjaN9mKN1IdcFEIl+E+Sp8jeA4AyphTXSO5ulNaMYWHDSMnyil0Q6s59qmC73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuN55xUDWimkSyjKWjdavQmSIL1EvlQo0elYM9HcRlA=;
 b=nQC54Mwpf19FxlXA5rOsJtyw9duX9SpZveAMWjUNYw0hSpiO9gF7aq4RMzXKbyoJhHW+/NGnER5Ki6XcG9hsKEgj0jF2PVCRPGdyVw10mRcwd0RTQFGPwMSagBgV3iC2zWTH4p5/OnVTfqFYMr/Thtyub/lVJ0ftQSHc6uBaNF+efV786sfcYGBfg5xDpLMEm5B2xfiOT+cMSYm2pZYRt1pOi+yVPxG21+REYjd2rHfTcK873oZ0SJvEID8QdVDCysw40V6qe/E9LpElQrtiS9QpW8kU83IPXmX9xN99lGqPw2ZweFFgsimVhTiIuLagB4nl/nFjq8O+54mMYUFOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuN55xUDWimkSyjKWjdavQmSIL1EvlQo0elYM9HcRlA=;
 b=zThIrISqfmUDr1ANCvPf7bhZFo8ibARVOQl/3l4x36YpKqks9nElJ4xkutHiPmUsa/qf+Zqla5ZR7jetYZhzRGUBErpdd5sn6ayKD+XF8xrtixyArM1NenqjIGOq42/EnSwV4Y1Yddd4lgEumb8cKuiE+0+w6pf5qoY0rLi+Q/o=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18)
 by MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 06:05:05 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e%12]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 06:05:05 +0000
From:   "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC:     Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Thread-Topic: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Thread-Index: AQHWwdw3n5VLcueYHUSP0T6AMdoDgKnWTbwAgAAE0oCAAIPUgIAACwGQgACBfgCAAPBvUA==
Date:   Wed, 25 Nov 2020 06:05:05 +0000
Message-ID: <MWHPR10MB13107611C2309BD0AECA685989FA0@MWHPR10MB1310.namprd10.prod.outlook.com>
References: <20201123134410.10648-1-will@kernel.org>
 <MN2PR12MB4488308D26DB50C18EA3BE0FF7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20201123223356.GC12069@willie-the-truck>
 <218017ab-defd-c77d-9055-286bf49bee86@amd.com>
 <20201124064301.GA536919@hr-amd>
 <MWHPR10MB13108B04F4765EA6E278660B89FB0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MN2PR12MB44884857E65E3599DA32D0B2F7FB0@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44884857E65E3599DA32D0B2F7FB0@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-24T15:01:54Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=de2f7a10-55c4-48b3-9a56-00005e730a8e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=emerson.com;
x-originating-ip: [194.140.114.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04168bb1-6338-4261-a17a-08d891080df7
x-ms-traffictypediagnostic: MWHPR10MB1582:
x-microsoft-antispam-prvs: <MWHPR10MB1582731C2BE95EF8565B4D4F89FA0@MWHPR10MB1582.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vjzZMRKiPg8wC3VJH418zmi8W/Y6AKYSw9pc6ZEWmqxtoTsiUj5CplFh4M1OIWzrj6GdY+HD2kpgGKpT0pJMSzdpt78RUfu8oW9WmDn+8YrUdNzytHfbpK/qvEobciTNELsxhqA2A9/4IwHpg1qs8zL9mZuxepnctIYeiveZ466Q0S9U/eNW/kOMf4zYiRFg52Sqe0PVsECLMeQNaC1+FYt/AXRaYKgt6inF8RkfMIR8F+qnrn21bvyrDMUo70JWe+4o04Xj5gegNMUD+J6/jkAgt8Sh9rmkuZkAl29gb4nkh9TSbUHas9x6svN+BZ7kTZ+7UMaw9rQEJX/ccL6igL1KFlQA59H1z1jCiweZlmYopd5LJl0Dlbd69SADeF6IsCfLvPHZrGtkfd1Dkwhg7FlQYgZefXXHMMRn0JXiOcd2Oh1WdzQqBFs/EIbxv01m5AMMIqWzoQnIY7xei/r9ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1310.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(366004)(136003)(86362001)(26005)(110136005)(7696005)(54906003)(2906002)(6506007)(8936002)(4001150100001)(52536014)(8676002)(4326008)(53546011)(186003)(7416002)(9686003)(19627235002)(64756008)(33656002)(66946007)(76116006)(66476007)(83380400001)(55016002)(5660300002)(316002)(66446008)(66556008)(30864003)(478600001)(966005)(45080400002)(71200400001)(505234006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WqzY06zrEAdxP4mh/xO1gutXPqRZuCa4dSLR1HTSsvIHwvDf1oVkgQbMlBB40c1XT/ymjtxTtuh54+QUFG8u0yG7d1/DJMImpge/hox+w6s8h73Kui0RSi7CQXCMYbWFAj1gYLxiRS21E0Ee4nyk8aGCbmV4LFXFrTJPWdVHX2Bx6t1PvMkxI4+NrKLlz7GC4cw4iBjPSwS1DVBvw8DesfeuW6PXQUo4v/TIV5Sq6H1xmTS7JuuNJuP6XSrTMnlem8yyFHW5Yfnr82rInJ3oN3RYJaQmZpekzcoyCEXsiYY9aO3IqGnd+dVIP5oaXSmABhqNnsCq+6dnzYuT0eqVKxCxS+J1/LNfkwvUoqS6w7iVdCbfCwsvPHlFzavC3VizTU4GSO0tiQ1j2GNE3lpf69xn98iH/2LMn0dCnmmWctHQozkCfKVXCUKefn71nS0RNFoX8j4g4yd7WmH/fL7eJiiIFpq56QtlPgWA+5d7ag69ufTSBXuECZr3GS1ZOSffG/lJJznAep36z9fIgXhrEVKHqD0FjjY83BxmrJ+MwveAqGWxbA1Fj9GgORrAdU2RvXG4YbSeE+jCxW0Dmg0fJ6c12T2CQgG1WEziTpRNHL/R94hwlhD4boClYQdE6Zq5XEMJBqEgFcLy4ENrsl4ZBM/dzHEt/72lhyiypL+OS/En1Y4qpOCa2tib2Gqub6y+0UUwuHvvNEjEIxCrHBE+0dM6zRE4fFQdQq1HxrxxFdd05evAjGQhcJkQUtMyNtNXsXKiiVGuTBrrF637KRWO2UyhlsJMNITVZ0EzMZE9eICjbovL/RmO9bJxbexAPsXxZ42f3L0a3BMoShbtYCQP9l/Zmw1tWDtUKmDMfAplWJ/AmtPqXNn7YIR1ONbSnviym2piBWYv03zRed0VIWilMQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04168bb1-6338-4261-a17a-08d891080df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 06:05:05.2024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZeTv5s0bU9hadfgrrTUC0YxFTVQuBTSQoSrhZPt8qziAC8EKZXOz8DyFVPxqt/8HfD7agsX6xidqfOuejPsaDO23Ct1BeslrWkHS37ONFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1582
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_02:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250036
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I see that problem only on systems that use a R1305G APU

sudo cat /sys/kernel/debug/dri/0/amdgpu_firmware_info

shows

VCE feature version: 0, firmware version: 0x00000000
UVD feature version: 0, firmware version: 0x00000000
MC feature version: 0, firmware version: 0x00000000
ME feature version: 50, firmware version: 0x000000a3
PFP feature version: 50, firmware version: 0x000000bb
CE feature version: 50, firmware version: 0x0000004f
RLC feature version: 1, firmware version: 0x00000049
RLC SRLC feature version: 1, firmware version: 0x00000001
RLC SRLG feature version: 1, firmware version: 0x00000001
RLC SRLS feature version: 1, firmware version: 0x00000001
MEC feature version: 50, firmware version: 0x000001b5
MEC2 feature version: 50, firmware version: 0x000001b5
SOS feature version: 0, firmware version: 0x00000000
ASD feature version: 0, firmware version: 0x21000030
TA XGMI feature version: 0, firmware version: 0x00000000
TA RAS feature version: 0, firmware version: 0x00000000
SMC feature version: 0, firmware version: 0x00002527
SDMA0 feature version: 41, firmware version: 0x000000a9
VCN feature version: 0, firmware version: 0x0110901c
DMCU feature version: 0, firmware version: 0x00000001
VBIOS version: 113-RAVEN2-117

We are also using V1404I APU on the same boards and I haven=B4t seen the is=
sue on those boards

These boards give me slightly different info: sudo cat /sys/kernel/debug/dr=
i/0/amdgpu_firmware_info
=20
VCE feature version: 0, firmware version: 0x00000000
UVD feature version: 0, firmware version: 0x00000000
MC feature version: 0, firmware version: 0x00000000
ME feature version: 47, firmware version: 0x000000a2
PFP feature version: 47, firmware version: 0x000000b9
CE feature version: 47, firmware version: 0x0000004e
RLC feature version: 1, firmware version: 0x00000213
RLC SRLC feature version: 1, firmware version: 0x00000001
RLC SRLG feature version: 1, firmware version: 0x00000001
RLC SRLS feature version: 1, firmware version: 0x00000001
MEC feature version: 47, firmware version: 0x000001ab
MEC2 feature version: 47, firmware version: 0x000001ab
SOS feature version: 0, firmware version: 0x00000000
ASD feature version: 0, firmware version: 0x21000013
TA XGMI feature version: 0, firmware version: 0x00000000
TA RAS feature version: 0, firmware version: 0x00000000
SMC feature version: 0, firmware version: 0x00001e5b
SDMA0 feature version: 41, firmware version: 0x000000a9
VCN feature version: 0, firmware version: 0x0110901c
DMCU feature version: 0, firmware version: 0x00000000
VBIOS version: 113-RAVEN-116




00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Root C=
omplex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h (Models =
00h-1fh) PCIe Dummy Host Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 PCIe GP=
P Bridge [6:0]
00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin Switch Upst=
ream (PCIE SW.US)
00:01.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 PCIe GP=
P Bridge [6:0]
00:01.5 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin Switch Upst=
ream (PCIE SW.US)
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h (Models =
00h-1fh) PCIe Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Interna=
l PCIe GPP Bridge 0 to Bus A
00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Interna=
l PCIe GPP Bridge 0 to Bus B
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev=
 61)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev =
51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device=
 24: Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device=
 24: Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device=
 24: Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device=
 24: Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device=
 24: Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device=
 24: Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device=
 24: Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device=
 24: Function 7
01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8=
411 PCI Express Gigabit Ethernet Controller (rev 0e)
01:00.1 Serial controller: Realtek Semiconductor Co., Ltd. Device 816a (rev=
 0e)
01:00.2 Serial controller: Realtek Semiconductor Co., Ltd. Device 816b (rev=
 0e)
01:00.3 IPMI Interface: Realtek Semiconductor Co., Ltd. Device 816c (rev 0e=
)
01:00.4 USB controller: Realtek Semiconductor Co., Ltd. Device 816d (rev 0e=
)
02:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connect=
ion (rev 03)
03:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-Lane=
 Packet Switch
04:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-Lane=
 Packet Switch
04:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-Lane=
 Packet Switch
04:03.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-Lane=
 Packet Switch
04:04.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-Lane=
 Packet Switch
04:05.0 PCI bridge: Pericom Semiconductor PI7C9X2G608GP PCIe2 6-Port/8-Lane=
 Packet Switch
06:00.0 Serial controller: Asix Electronics Corporation Device 9100
06:00.1 Serial controller: Asix Electronics Corporation Device 9100
07:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connect=
ion (rev 03)
0a:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connect=
ion (rev 03)
0b:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] P=
icasso (rev cf)
0b:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Raven/Raven2/F=
enghuang HDMI/DP Audio Controller
0b:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17=
h (Models 10h-1fh) Platform Security Processor
0b:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raven2 USB 3.1
0b:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] Raven/Rav=
en2/FireFlight/Renoir Audio Processor
0b:00.7 Non-VGA unclassified device: Advanced Micro Devices, Inc. [AMD] Rav=
en/Raven2/Renoir Non-Sensor Fusion Hub KMDF driver
0c:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Contro=
ller [AHCI mode] (rev 61)

PCI Revision ID is 06 I believe. Got that from this lspci -xx

00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Zeppelin Switch Upst=
ream (PCIE SW.US)
00: 22 10 5d 14 07 04 10 00 00 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f1 01 00 00
20: e0 fc e0 fc f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 12 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 58 03 c8 00 00 00 00 10 a0 42 01 22 80 00 00
60: 1f 29 00 00 13 38 73 03 42 00 11 30 00 00 04 00
70: 00 00 40 01 18 00 01 00 00 00 00 00 bf 01 70 00
80: 06 00 00 00 0e 00 00 00 03 00 01 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 05 c0 81 00 00 00 e0 fe 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 0d c8 00 00 22 10 34 12 08 00 03 a8 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 4c 8a 05 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>=20
Sent: Dienstag, 24. November 2020 16:06
To: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>; Huang, Ray=
 <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Will Deacon <will@kernel.org>; linux-kernel@vger.kernel.org; linux-pci@=
vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn Helgaas <bhelgaas@=
google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, Changfeng <Changfeng.Zhu@=
amd.com>
Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken

[AMD Public Use]

> -----Original Message-----
> From: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>
> Sent: Tuesday, November 24, 2020 2:29 AM
> To: Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix=20
> <Felix.Kuehling@amd.com>
> Cc: Will Deacon <will@kernel.org>; Deucher, Alexander=20
> <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org; linux-=20
> pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn Helgaas=20
> <bhelgaas@google.com>; Joerg Roedel <jroedel@suse.de>; Zhu, Changfeng=20
> <Changfeng.Zhu@amd.com>
> Subject: RE: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as=20
> broken
>=20
> Module Version : PiccasoCpu 10
> AGESA Version   : PiccasoPI 100A
>=20
> I did not try to enter the system in any other way (like via ssh) than=20
> via Desktop.

You can get this information from the amdgpu driver.  E.g., sudo cat /sys/k=
ernel/debug/dri/0/amdgpu_firmware_info .  Also what is the PCI revision id =
of your chip (from lspci)?  Also are you just seeing this on specific versi=
ons of the sbios?

Thanks,

Alex


>=20
> -----Original Message-----
> From: Huang Rui <ray.huang@amd.com>
> Sent: Dienstag, 24. November 2020 07:43
> To: Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Will Deacon <will@kernel.org>; Deucher, Alexander=20
> <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org; linux-=20
> pci@vger.kernel.org; iommu@lists.linux-foundation.org; Bjorn Helgaas=20
> <bhelgaas@google.com>; Merger, Edgar [AUTOSOL/MAS/AUGS]=20
> <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>; Changfeng=20
> Zhu <changfeng.zhu@amd.com>
> Subject: [EXTERNAL] Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
>=20
> On Tue, Nov 24, 2020 at 06:51:11AM +0800, Kuehling, Felix wrote:
> > On 2020-11-23 5:33 p.m., Will Deacon wrote:
> > > On Mon, Nov 23, 2020 at 09:04:14PM +0000, Deucher, Alexander wrote:
> > >> [AMD Public Use]
> > >>
> > >>> -----Original Message-----
> > >>> From: Will Deacon <will@kernel.org>
> > >>> Sent: Monday, November 23, 2020 8:44 AM
> > >>> To: linux-kernel@vger.kernel.org
> > >>> Cc: linux-pci@vger.kernel.org; iommu@lists.linux-foundation.org;=20
> > >>> Will Deacon <will@kernel.org>; Bjorn Helgaas=20
> > >>> <bhelgaas@google.com>; Deucher, Alexander=20
> > >>> <Alexander.Deucher@amd.com>; Edgar Merger=20
> > >>> <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>
> > >>> Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
> > >>>
> > >>> Edgar Merger reports that the AMD Raven GPU does not work=20
> > >>> reliably on his system when the IOMMU is enabled:
> > >>>
> > >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx=20
> > >>> timeout, signaled seq=3D1, emitted seq=3D3
> > >>>    | [...]
> > >>>    | amdgpu 0000:0b:00.0: GPU reset begin!
> > >>>    | AMD-Vi: Completion-Wait loop timed out
> > >>>    | iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> > >>> device=3D0b:00.0 address=3D0x38edc0970]
> > >>>
> > >>> This is indicative of a hardware/platform configuration issue=20
> > >>> so, since disabling ATS has been shown to resolve the problem,=20
> > >>> add a quirk to match this particular device while Edgar=20
> > >>> follows-up with AMD
> for more information.
> > >>>
> > >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> > >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> > >>> Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
> > >>> Suggested-by: Joerg Roedel <jroedel@suse.de>
> > >>> Link:
> > >>>
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__nam11.safelinks.p
> rotection.outlook.com_-3Furl-3Dhttps-253A-252F-252Furld&d=3DDwIFAw&c=3DjO=
U
> RTkCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-862rdSP1
> 3_P6LVp7j_9l1xmg&m=3DMMI_EgCqeOX4EvIftpL7agRxJ-udp1CLokf2QWuzFgE&s=3DZLdz=
6
> OgavzNn2vSzsgyL1IB6MbK7hPKavOYwbLhyTPU&e=3D
> efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__lore%26d%3DDwIDAw%26c%3DjOURTkCZzT8tVB5xPEYIm3YJGoxoTaQs
> QPzPKJGaWbo%26r%3DBJxhacqqa4K1PJGm6_-
> 862rdSP13_P6LVp7j_9l1xmg%26m%3DlNXu2xwvyxEZ3PzoVmXMBXXS55jsmf
> DicuQFJqkIOH4%26s%3D_5VDNCRQdA7AhsvvZ3TJJtQZ2iBp9c9tFHIleTYT_ZM
> %26e%3D&amp;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C6d5f
> a241f9634692c03908d8904a942c%7C3dd8961fe4884e608e11a82d994e183d%7
> C0%7C0%7C637417997272974427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> 0&amp;sdata=3DOEgYlw%2F1YP0C%2FnWBRQUxwBH56mGOJxYMWSQ%2Fj1Y
> 9f6Q%3D&amp;reserved=3D0 .
> > >>> kernel.org/linux-
> > >>>
> iommu/MWHPR10MB1310F042A30661D4158520B589FC0@MWHPR10M
> > >>> B1310.namprd10.prod.outlook.com
> > >>>
> her%40amd.com%7C1a883fe14d0c408e7d9508d88fb5df4e%7C3dd8961fe488
> > >>>
> 4e608e11a82d994e183d%7C0%7C0%7C637417358593629699%7CUnknown%7
> > >>>
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > >>>
> LCJXVCI6Mn0%3D%7C1000&amp;sdata=3DTMgKldWzsX8XZ0l7q3%2BszDWXQJJ
> > >>> LOUfX5oGaoLN8n%2B8%3D&amp;reserved=3D0
> > >>> Signed-off-by: Will Deacon <will@kernel.org>
> > >>> ---
> > >>>
> > >>> Hi all,
> > >>>
> > >>> Since Joerg is away at the moment, I'm posting this to try to=20
> > >>> make some progress with the thread in the Link: tag.
> > >> + Felix
> > >>
> > >> What system is this?  Can you provide more details?  Does a sbios=20
> > >> update fix this?  Disabling ATS for all Ravens will break GPU=20
> > >> compute for a lot of people.  I'd prefer to just black list this=20
> > >> particular system (e.g., just SSIDs or revision) if possible.
> >
> > +Ray
> >
> > There are already many systems where the IOMMU is disabled in the=20
> > BIOS, or the CRAT table reporting the APU compute capabilities is=20
> > broken. Ray has been working on a fallback to make APUs behave like=20
> > dGPUs on such systems. That should also cover this case where ATS is=20
> > blacklisted. That said, it affects the programming model, because we=20
> > don't support the unified and coherent memory model on dGPUs like we=20
> > do on APUs with IOMMUv2. So it would be good to make the conditions=20
> > for this workaround as narrow as possible.
>=20
> Yes, besides the comments from Alex and Felix, may we get your=20
> firmware version (SMC firmware which is from SBIOS) and device id?
>=20
> > >>>    | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx=20
> > >>> timeout, signaled seq=3D1, emitted seq=3D3
>=20
> It looks only gfx ib test passed, and fails to lanuch desktop, am I right=
?
>=20
> We would like to see whether it is Raven, Raven kicker (new Raven), or=20
> Picasso. In our side, per the internal test result, we didn't see the=20
> similiar issue on Raven kicker and Picasso platform.
>=20
> Thanks,
> Ray
>=20
> >
> > These are the relevant changes in KFD and Thunk for reference:
> >
> > ### KFD ###
> >
> > commit 914913ab04dfbcd0226ecb6bc99d276832ea2908
> > Author: Huang Rui <ray.huang@amd.com>
> > Date:=A0=A0 Tue Aug 18 14:54:23 2020 +0800
> >
> >  =A0=A0=A0 drm/amdkfd: implement the dGPU fallback path for apu (v6)
> >
> >  =A0=A0=A0 We still have a few iommu issues which need to address, so=20
> > force raven
> >  =A0=A0=A0 as "dgpu" path for the moment.
> >
> >  =A0=A0=A0 This is to add the fallback path to bypass IOMMU if IOMMU v2=
 is=20
> > disabled
> >  =A0=A0=A0 or ACPI CRAT table not correct.
> >
> >  =A0=A0=A0 v2: Use ignore_crat parameter to decide whether it will go w=
ith=20
> > IOMMUv2.
> >  =A0=A0=A0 v3: Align with existed thunk, don't change the way of raven,=
=20
> > only renoir
> >  =A0=A0=A0=A0=A0=A0=A0 will use "dgpu" path by default.
> >  =A0=A0=A0 v4: don't update global ignore_crat in the driver, and revis=
e=20
> > fallback
> >  =A0=A0=A0=A0=A0=A0=A0 function if CRAT is broken.
> >  =A0=A0=A0 v5: refine acpi crat good but no iommu support case, and ren=
ame=20
> > the
> >  =A0=A0=A0=A0=A0=A0=A0 title.
> >  =A0=A0=A0 v6: fix the issue of dGPU initialized firstly, just modify t=
he=20
> > report
> >  =A0=A0=A0=A0=A0=A0=A0 value in the node_show().
> >
> >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> >  =A0=A0=A0 Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> >  =A0=A0=A0 Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > ### Thunk ###
> >
> > commit e32482fa4b9ca398c8bdc303920abfd672592764
> > Author: Huang Rui <ray.huang@amd.com>
> > Date:=A0=A0 Tue Aug 18 18:54:05 2020 +0800
> >
> >  =A0=A0=A0 libhsakmt: remove is_dgpu flag in the hsa_gfxip_table
> >
> >  =A0=A0=A0 Whether use dgpu path will check the props which exposed fro=
m kernel.
> >  =A0=A0=A0 We won't need hard code in the ASIC table.
> >
> >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> >  =A0=A0=A0 Change-Id: I0c018a26b219914a41197ff36dbec7a75945d452
> >
> > commit 7c60f6d912034aa67ed27b47a29221422423f5cc
> > Author: Huang Rui <ray.huang@amd.com>
> > Date:=A0=A0 Thu Jul 30 10:22:23 2020 +0800
> >
> >  =A0=A0=A0 libhsakmt: implement the method that using flag which expose=
d=20
> > by kfd to configure is_dgpu
> >
> >  =A0=A0=A0 KFD already implemented the fallback path for APU. Thunk wil=
l=20
> > use flag
> >  =A0=A0=A0 which exposed by kfd to configure is_dgpu instead of hardcod=
e before.
> >
> >  =A0=A0=A0 Signed-off-by: Huang Rui <ray.huang@amd.com>
> >  =A0=A0=A0 Change-Id: I445f6cf668f9484dd06cd9ae1bb3cfe7428ec7eb
> >
> > Regards,
> >  =A0 Felix
> >
> >
> > > Cheers, Alex. I'll have to defer to Edgar for the details, as my=20
> > > understanding from the original thread over at:
> > >
> > >
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__nam11.safelinks.p
> rotection.outlook.com_-3Furl-3Dhttps-253A-252F-252Fur&d=3DDwIFAw&c=3DjOUR=
T
> kCZzT8tVB5xPEYIm3YJGoxoTaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-862rdSP13_
> P6LVp7j_9l1xmg&m=3DMMI_EgCqeOX4EvIftpL7agRxJ-udp1CLokf2QWuzFgE&s=3DIPZRol=
k
> y3TYlbWPsOkY37MbDdzwhc1b_LaE6JkaOkOo&e=3D
> > > ldefense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-
> 3A__lore.kernel.org&a
> > >
> mp;data=3D04%7C01%7CAlexander.Deucher%40amd.com%7C6d5fa241f963469
> 2c039
> > >
> 08d8904a942c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63741
> 79972
> > >
> 72974427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzI
> > >
> iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DiKTPucGQqcRXET
> QZiQz
> > > j90WdJeCYDytdZHJ1ZiUyR%2FM%3D&amp;reserved=3D0
> > > _linux-2Diommu_MWHPR10MB1310CDB6829DDCF5EA84A14689150-
> 40MWHPR10MB131
> > >
> 0.namprd10.prod.outlook.com_&d=3DDwIDAw&c=3DjOURTkCZzT8tVB5xPEYIm3Y
> JGoxo
> > > TaQsQPzPKJGaWbo&r=3DBJxhacqqa4K1PJGm6_-
> 862rdSP13_P6LVp7j_9l1xmg&m=3DlNXu
> > >
> 2xwvyxEZ3PzoVmXMBXXS55jsmfDicuQFJqkIOH4&s=3DdsAVVJbD7gJIj3ctZpnnU
> 60y21
> > > ijWZmZ8xmOK1cO_O0&e=3D
> > >
> > > is that this is a board developed by his company.
> > >
> > > Edgar -- please can you answer Alex's questions?
> > >
> > > Will
