Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182D44675DA
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 12:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243867AbhLCLHE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 06:07:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47330 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232427AbhLCLHE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 06:07:04 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B39l0t2018009;
        Fri, 3 Dec 2021 11:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=jyscdkhSy4Wq57XqB5UI8CCGaZXmeZFyvyCMdAwXKyE=;
 b=AsYcbPX7+hE7AtFkxtYAGuPiaMQG+RzRUIwnqmxCDyV/22ZSESSIGdsdN269GcM7YyjC
 znbFkXTEXGYGERPU2osHzkVaaxy3moME93J/3xwFQjNqc2LeE4qeJb0YSUAiHW2A/EMm
 if9bmJvYjvF60JSjsGkfnbvpujuYLYzHoDefE5PavvEzox5iezOL32tsKAqa3tPNPlcr
 4ZyUBxXMnHBLOSkEqiDy5S8N779NO3/fkg7ixmrSR15eJCPXc6RLvuSJz987ZmZOV+Fl
 zLptXvKZt5u7fm2y343wcPcTi1sw4FqRX36sCsy4eosFtKbV63DfraNkB6YrAnqtX4UI Sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cqgwmgat8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 11:03:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B3AutrN097341;
        Fri, 3 Dec 2021 11:03:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3030.oracle.com with ESMTP id 3ck9t601rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 11:03:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU0aOiUwtiwm9fJ8APtIVoZNCShXDLl39BRtR06rv5UABk/RNfArycnlJ5rhWXTBy93JZaBg5nVCrk+D2HGt7kaOjldFmxwTuEVM1Jv2i06P4ooZQZtRJGgMrThX7nnxEpDJ/sZv7216umZtDB19Opbh6EGR42X+svZhXXPZmC0z7l70Bqb3KXdesudz+RAWDqtxV+5aanA8Iq0KlMoByQPNxbr99qcv89sfuNRorbOl2NyooHEnckxByc8bBDfaKrNdHEYaNwkPXusMVPzxJZxbNHaZY+FDFkSjUcB5cG7u2+YHvLCISbECXdLsFKioMTHrp8OMUjYZrj3OoPM/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyscdkhSy4Wq57XqB5UI8CCGaZXmeZFyvyCMdAwXKyE=;
 b=SMrWaSqQr2+TXYJFjulFZosMZ73HG1cDQi5sIYKminMpwT7B3DkU10EjKzcRwtCgShCRaDtnAREIUFCzbFiwjV0Av54xjKOG4r/g52WzU7evNL7lCQ+RyOmYxolBMRdDU0GUi1nOIJNvo+Le8cdmhgss8hl7G5TR3DDnLZbYpSozHSpe6wz7WEx1gwW8S3/hRbD8l8WCwYLUSw9pLuGEykuQRpcyocIOVmyEF+8MzxqKxDIWvUGI3vtWOAxb81gskfEld0lJd4HcI/OFecpBvwBMTK9MKwLfvsykV2bqnd0VT90rP2JzhlZS/JQ/KfcP22eNajJul9S6YGLskdtmGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyscdkhSy4Wq57XqB5UI8CCGaZXmeZFyvyCMdAwXKyE=;
 b=VLSBd1+ic98w6tYDoq/KUaImtTNVqPy504U4CCtXKfs8K4j2poc0WWHJ4nrRpCLqUjiXqB6BidMPDy7t1S34flDQtfLXHGN6HepLK8FkyGe46W5WDguyumpQ4Bn47F7SQB9tZoftKo7RbDqf4NEwG4HAYX35Te+OcHziGA6sh4A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5849.namprd10.prod.outlook.com
 (2603:10b6:303:19b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 3 Dec
 2021 11:03:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Fri, 3 Dec 2021
 11:03:18 +0000
Date:   Fri, 3 Dec 2021 14:02:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        nsaenz@kernel.org, jim2101024@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: brcmstb: Declare a bitmap as a bitmap, not as a
 plain 'unsigned long'
Message-ID: <20211203110248.GH9522@kadam>
References: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
 <20211130170417.GA2744534@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130170417.GA2744534@bhelgaas>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0068.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0068.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Fri, 3 Dec 2021 11:03:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b43197b7-72ce-4ee6-7286-08d9b64c831f
X-MS-TrafficTypeDiagnostic: MW5PR10MB5849:
X-Microsoft-Antispam-PRVS: <MW5PR10MB584944FC612AE6996E252C098E6A9@MW5PR10MB5849.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4M7MnL5aRrNYc6xBS5LizBkZ5FuI62Qmgy6rzfPYNBlEJG0nsEDk41U4hP8g5G77m2SA++wegUXZTlevkH3f6JLCywSPiUf7nM4oYseqSMTX+LSPE1q6kEA351cD6kbgnbwKuIuKYeF+hpusTgDdUmjEJIXNQl8Pe63v9rrO6375ZBIGzf94aNN9MU1Cj5K+3AB/27KsLacR8vBdq+ihWCzcmH8yB2X0qs7y6NuK4JQXLw+gpStIM1W1SpOjzFWrnDhLRq06ObmO01j8SzM2D6Rfk5vhloLT2EJAlLl2eEDMu6cWGDkwF3vQccm1DeUHMz/4uBFI01EW6K6Nyy6/95JGLc6+GxqnWEFPlLmxtlTXKbSZqtt0RgiQR69HviCX7K/lZ5KgnSCBLg+Ro1o0WhbQPpjBjd47IvZHcDKxh7S573ba3WXbPsvo9r5sxm+37aysrdlV3c1wz96VxCGM0aLUYidlA/6QJdHEWTRtQZoyyGoqUBVsHj9piucTXaZfVhC9rSgqEJ64gasujoMELlmSJaSfP+IyEyeaUg5Lgt+eIoaShzbX8nb+iTL2x9mcRco/p7JLVq8yJTDEj0fm09RmmEahcjBYyFoSOYRLI01CPr/T3HrsYUYZKw7x1sPB/a3SZEwEA/d4Js8p9JK45T5EWm2vjdGhbQHgI/N93IwR8nUCAIcwS4rLv1D+aURnEvtUbfpQ0DHUNU6wtzySQNlz5a89mWRL9OEaS1U6i4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(38350700002)(38100700002)(5660300002)(6666004)(6496006)(7416002)(316002)(6916009)(8676002)(9576002)(508600001)(33716001)(44832011)(52116002)(2906002)(66946007)(1076003)(83380400001)(86362001)(9686003)(66476007)(66556008)(33656002)(55016003)(26005)(4326008)(186003)(8936002)(133343001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5bEsxVE6L38jHhwbVyD6Wg1mX/8pBIRYIlwsLmuTXU976ECgJqmbSgVpKcgr?=
 =?us-ascii?Q?v3TX2I4QHwEYWTVdg1PcUCEfpYJ/M1uCSpWryEzMx85Ni+P3LiqT5ZJJKAoq?=
 =?us-ascii?Q?grQCxCpLajiPTfURcbnos5u6kQ4f1HVRscxvlpPisYAlciDFUfqv88uH3Zfe?=
 =?us-ascii?Q?dMx/vKJHs+elFtG6lNOGuFSdGLqSle8tGe/qE96b6EyF26s05kPx9C4ADi55?=
 =?us-ascii?Q?6soo4qfM+0pbcllErvxpjGWxS6YYkzU3+oGxUEiOowQh+vvof+97tVIXMyKw?=
 =?us-ascii?Q?MGDMxBehYTC2PhaXKN0LF6T0+hH8eKuwAlSFw1GoAHbZtkEdg4aEbKDOiVgM?=
 =?us-ascii?Q?CpdBIV8cdPH8wk8wriYD88oV360yaAHNIJuWLphov8BoCuIjmLzjd73NAPPZ?=
 =?us-ascii?Q?i4LR/5qgrrolLiVWRaRxIOM66WE+KCMPbVgD7/P88bXyj0mI8Y+1MZj284M9?=
 =?us-ascii?Q?THR68Wz+8kopFu/w0KcIAgMNtNpHY0zrHrc2TKVGJTjJ8T0caqXpyaPomHps?=
 =?us-ascii?Q?wMGzWnVtTq0QVAblIrdJ5sy8wtioAeV2p1RIutN02xd/nwsf3ZTuQlMIrQwP?=
 =?us-ascii?Q?n40HfCdtyhR2zYbQxI0GRNMBpinMbos5G+mfUq+q3MMocvYGzj4ZIEg3ufPv?=
 =?us-ascii?Q?kUvL6m+Su8xGN0w6TcsrZqs6bKSJMdRiYR9OSfd0hJdno8tgmpA2cNb+iCCV?=
 =?us-ascii?Q?hoyK6ehDUfQXwAxWqcsgw9H2JafDSD94AYSusUSRmciKTc7S1w+b979JoeNv?=
 =?us-ascii?Q?dcLyUnMuaORYQ4USkADQn9iBdSks7iVbIIyQt+F95He4h9PaDKG+Lev7+igG?=
 =?us-ascii?Q?g+O7HPYrIFXmD6bwBQZyKfWpChqVp6JLgw06rn7ml2fqPguYCP4d7e9lArWo?=
 =?us-ascii?Q?bQvh+aCH5goN2/sGAsVsN3BRyDeWvvTAnmW99Jfz3owde5rQaWtJgljrg5Eu?=
 =?us-ascii?Q?9tuPtd19rC2U3/IfFVaLjBD0xcW0O8Qczev/rzVIXAiV+KkRX61m5ca6Eczx?=
 =?us-ascii?Q?TN2PNiLUmHpr0p7GAjVeF1AVFYgAD2RaZUwEk3MF47TlVjvUcVW0cuivPMiY?=
 =?us-ascii?Q?T8TjiAntkomYz3WAzOETohuBhAk6R3xapW4hPNfj9m4V4jz3+7O5I0eQ4zzN?=
 =?us-ascii?Q?gE2EBwi19Dw65ya2B4zI+ZuOENTqrjmzlDMCKUJP2dHQ9QnhvtM37NpDS4Ap?=
 =?us-ascii?Q?qAsEWbj82gwn/ItgYy8HmP9cv4oMvnHE+0+ib7x6ZLBdeO4uVUY6ZC2A3TnH?=
 =?us-ascii?Q?9hcVHOvAS73SSwHcqgKWYxE8gPFYasMCD/QQl1diInT5SveFaJZzf0LBqxGL?=
 =?us-ascii?Q?rGEbUVW2Ingor98g0OW4qmJ+7QQ5eYuwwGc9mzZzKEDQ3SyEdcL+KRpxiamz?=
 =?us-ascii?Q?gxIEwwqYLEo8KoVt2OXmYw6j4c67Vb8C74p5UpttMR3euJXwdm7yXoPyj3kT?=
 =?us-ascii?Q?AJj6BB2nku4TIQZoLtNlHGBYOx3fjzp6VmCl3cmlo0hBNihFXbe2BFsBWACX?=
 =?us-ascii?Q?FCAusOWWEM4NVkF8XaukCXwcFCJbCo8/5qo9Efqi3GwLQ41PXDWFjpqUFgYM?=
 =?us-ascii?Q?N2WNsgw03mFKX7Bn8GGJ3Zj3IJbCyvy5APEeJyonsUqtfrw1/fHumCBvsMmg?=
 =?us-ascii?Q?xrqUQUwmPFIRbzpnMhfBGsk6rabQ41kttWATfZQ2Ip+NYVLdNIadGnIUiLfG?=
 =?us-ascii?Q?SThKQnvGywN5xl4fLxTN/4Z3d6k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43197b7-72ce-4ee6-7286-08d9b64c831f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 11:03:18.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q33locKJDXMNZddTx4AaE1Rj0BXochUmO8ZaJFQdxdtI3Q4TXbKm9d9BNUtRzV9e3pH3EKI6cw/QieS0RpgMbYSUiDznN566hL0nkUjTRQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5849
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030068
X-Proofpoint-GUID: 5DtGsx8BpL_1gOpRnSxh_ZjeyWuNq93T
X-Proofpoint-ORIG-GUID: 5DtGsx8BpL_1gOpRnSxh_ZjeyWuNq93T
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 30, 2021 at 11:04:17AM -0600, Bjorn Helgaas wrote:
> > +	/* Used indicates which MSI interrupts have been alloc'd. 'nr' bellow is
> > +	   the real size of the bitmap. It depends on the chip. */
> 
> I hate to bike-shed this even more, but IMO we should just drop the
> comment above completely.  It's not the usual commenting style, no
> other drivers provide similar explanation, and "below" is misspelled,
> which will lead to a future fixup patch.
> 

There a bunch of these...

$ git grep -wi bellow
Documentation/input/devices/ntrig.rst:|min_height,              |size threshold bellow which fingers are ignored      |
Documentation/networking/arcnet-hardware.rst:the I/O address space bellow 0x200 is RESERVED for mainboard, so
Documentation/networking/regulatory.rst:Bellow is a simple example, with a regulatory domain cached using the stack.
Documentation/security/digsig.rst:of the key: 5D2B05FC633EE3E8 in the example bellow.
Documentation/sound/alsa-configuration.rst:    bitmap of available external inputs for FX8010 (see bellow)
Documentation/sound/alsa-configuration.rst:    bitmap of available external outputs for FX8010 (see bellow)
arch/arm/mach-s3c/mach-mini2440.c: * This macro simplifies the table bellow
arch/arm/mm/kasan_init.c:        * At first we should unmap early shadow (clear_pgds() call bellow).
arch/arm/mm/pmsa-v7.c:                 * data access till we setup RAM bellow would be done
arch/mips/include/asm/sgi/mc.h:  * be the same size. The size encoding for supported SIMMs is bellow */
drivers/edac/sb_edac.c:  * algorithm bellow.
drivers/edac/sb_edac.c:  * The check bellow is probably enough to fill all cases where
drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c: * The 2 macros bellow represent the actual size in bytes that
drivers/gpu/drm/i915/display/intel_psr.c:                * comments bellow for more information
drivers/gpu/drm/i915/gt/shaders/README:The instructions bellow assume:
drivers/gpu/drm/rockchip/cdn-dp-reg.h:/* bellow registers need access by mailbox */
drivers/gpu/drm/sun4i/sun8i_mixer.h: * Sub-engines listed bellow are unused for now. The EN registers are here only
drivers/gpu/drm/tidss/tidss_dispc_regs.h: * macros bellow can be used.
drivers/gpu/drm/tidss/tidss_plane.c:     * (the two first checks bellow). At the end of a row the HW
drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h:/* Refer to the Register Bit Masks bellow for the naming of each register and */
drivers/net/ethernet/freescale/fman/fman_port.c:        /* The code bellow is a trick so the FM will not release the buffer
drivers/net/wireless/ath/ath6kl/wmi.h:  /* lowest of bellow */
drivers/net/wireless/ath/ath6kl/wmi.h:  /* highest of bellow */
drivers/net/wireless/ath/ath6kl/wmi.h:  /* lowest of bellow */
drivers/net/wireless/ath/ath6kl/wmi.h:  /* highest of bellow */
drivers/net/wireless/ath/wcn36xx/wcn36xx.h: * used in both SMD channel and TX BD. See table bellow when it is used.
drivers/power/supply/adp5061.c:          * bellow this value, weak charge mode is entered
drivers/pwm/pwm-stm32.c:                scale = priv->max_arr; /* bellow resolution, use max scale */
drivers/thermal/ti-soc-thermal/dra752-bandgap.h: * All the macros bellow define the required bits for
drivers/thermal/ti-soc-thermal/dra752-bandgap.h: * All the macros bellow are definitions for handling the
drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h: * All the macros bellow define the required bits for
drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h: * All the macros bellow are definitions for handling the
drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h: * All the macros bellow define the required bits for
drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h: * All the macros bellow are definitions for handling the
drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h: * All the macros bellow define the required bits for
drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h: * All the macros bellow are definitions for handling the
drivers/video/fbdev/omap2/omapfb/dss/hdmi.h:    /* This lock should be taken when booleans bellow are touched. */
drivers/video/fbdev/via/lcd.c:  DEBUG_MSG(KERN_INFO "bellow viafb_lcd_set_mode!!\n");
sound/soc/codecs/tlv320aic31xx.c:               /* See bellow for details how fix this. */
tools/perf/builtin-help.c:      char *page_path; /* it leaks but we exec bellow */

regards,
dan carpenter

