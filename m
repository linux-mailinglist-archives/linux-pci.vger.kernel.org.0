Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C5A51F10E
	for <lists+linux-pci@lfdr.de>; Sun,  8 May 2022 22:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiEHUXL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 May 2022 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiEHUXK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 May 2022 16:23:10 -0400
X-Greylist: delayed 33077 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 May 2022 13:19:18 PDT
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B62DF67
        for <linux-pci@vger.kernel.org>; Sun,  8 May 2022 13:19:17 -0700 (PDT)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2488S0Yr020697;
        Sun, 8 May 2022 11:07:50 GMT
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2053.outbound.protection.outlook.com [104.47.9.53])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3fwmeq1hcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 May 2022 11:07:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyRAJiuz5RFTxhbdb7uReAC0HziaBwo9hAQjHaR1au98+YUY/gjjpmZ5AEtZu4TCG7oythDhW+Ys5ZB+nYeX4bskaG3boZOAwEvw7FctuY9MlaSYJW8kpvtRX8EamaTKylzr4xbiD+m+zLd7+ZeJWeajYKAqKn9INcVXYtDLWUaGBKCjfbk6bko9Z/Dac2QdtTl4Myo3DnvrvZ8Lc75kEN0JjFLV+Wv3d2XYrkTNODARUMTTpamDFtEbhknaQDjN/3VCDEsQO3hZpiyeb3NudvtQRZYNHAqOKh+fa+aMfIjWd4fmrs1awcvaRirb/hr4sGsB8ZFGfZAvEGRUCtryLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKAGD6Rohukt8xtO4OFWuMTBOtpsiTD1nzT0TmwmbGo=;
 b=ROKGbI579erKu+U0OlFM1jmrBZmsgkBwfXYPXRwn7E/RpY098t65AvJqL4uLK578SYRFNNkvLbzmaBQO8I2ng/wX/KXtEzFHLWaxTOq/PNomdoY4iZxwB8jn1kSUC4t5XewFEcI7h8vnxyS0q+B+Jo8EHxUdcnQbqVPNchnasNFr3MMhqB3DxZ0jqXP6gd8XbQSbzIye8Xh5cSLqNzdo/H0hQ+/Em5AzCBa+yxvW323QEu/EB9ZdKd1tX16hTsbB5X3112xgVr3iiihsea/FKxzOrB6VVcFElde/onjAci5OHP2mgWMWydvPapnEaLQS/14qIbm698YOlcTGXKnL8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKAGD6Rohukt8xtO4OFWuMTBOtpsiTD1nzT0TmwmbGo=;
 b=CH9oP3ARCjRh+1yjWdq0GdneiwCiXHCqdCH0dJp1uIVCz0eAXT1gugZPJ843I1A28P7zvir7SOpH2ZKu4YJjdDIopiIS/mZJlh21xJjb55yWUR0yUBwz/6WNjOmoK/XgEN4oAr/34jIPkGlqnZkn7MrkkcKDxfEC3vSfhirKTygHLH4M+ikRjzX3DtoRDrFXzbcFzr849iBIENuO91K6y1McjVwb6pDValjmaTst2+nWGCeoiOwmhHSc3xkpV+Nr8DTfanmy/IP+aqjwGGS7GqTItYALqa0wiev+L73w6Lg1xsGGBXyzgzfhD62q2ycXdOw65tcnc9q/ckM9f+qL/Q==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by DU2PR03MB8121.eurprd03.prod.outlook.com (2603:10a6:10:2f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Sun, 8 May
 2022 11:07:40 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::4534:2241:9a1:3937]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::4534:2241:9a1:3937%6]) with mapi id 15.20.5227.022; Sun, 8 May 2022
 11:07:40 +0000
From:   Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Write to srvio_numvfs triggers kernel panic
Thread-Topic: Write to srvio_numvfs triggers kernel panic
Thread-Index: AQHYX/D7w22LhOQ4BkKjl8Bb5V4dfa0STLQAgADl+oCAAF9ZgIABPykA
Date:   Sun, 8 May 2022 11:07:40 +0000
Message-ID: <87ee14l1tx.fsf@epam.com>
References: <87v8uhlk1w.fsf@epam.com> <20220507154145.GA568412@bhelgaas>
In-Reply-To: <20220507154145.GA568412@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.6.5; emacs 27.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 440d8bd7-203d-48d5-9984-08da30e2f7c7
x-ms-traffictypediagnostic: DU2PR03MB8121:EE_
x-microsoft-antispam-prvs: <DU2PR03MB812140E58CB1D664E8F546ACE6C79@DU2PR03MB8121.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MXVBd+xuie2TEva/FQLMZNU8Qvb+LC6aT98/QVsmCYq4RAG95V7pTHk0mXfnT+hWoeSOCwUdeDqAay+sdxd7frJORBqN7YqePMVAG20vxChvp3yDlok6wkO+afA25vu/SkQM50qKrSdB9l3EnJr3ECfl8SyZ0xN0cWKa8sMlVhXs4QAgcSkqYvF05u9VB9ThBT9eAlldARTyfKGdCw8bfX9pfd18o3xYKYUPO9lAWeq2weewCNp1pSPuAAeTsrQ4Cf/ATjdJxSUvgMekfrqRSWP/8bhFRoz5c2DMEiIMfmT2Bi9PyGYUXpPPW6+pgtVxXXwNIr/2Oqkwi1bqFZOdtonATWhUKV4iRtuR5bVNf9LaX2TBigVOfzv/W4nO6MyEqkTKDak5YG6bRJt+sKdCoLTCUqx+1Thevo/4Ary82XbWpG6VuBArpJVDmj3UMFVJ9MMgC+StJaCc6JjCzJewQF4ZI7Z+I6xjsiFUuqAKjJYJP4/XhD0tDo7J7hQwL71eNt/6OxXKOV+UXyj9CWrDO0miDk0VAfG+6wK2MAP84rLZY9gPBLw/ehbOoy8NoUcDKAe/ZxV8Q4U73/iSZM9rF6sWZUzA5tT8dCyEXyX5zuYoaUnh+4LeVCBm1HxGvbcUZ7vvBZ2XCCiAVBJFlldTKiIeRYr93tFPt6KgKi2uzaEtBrXrNbnLfCiQRIUBgxYR1qoBGBNu7tN0MFOZhmD9hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3710.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(2616005)(122000001)(91956017)(5660300002)(36756003)(6506007)(83380400001)(38070700005)(8936002)(6512007)(508600001)(26005)(30864003)(66946007)(66556008)(6486002)(66476007)(64756008)(66446008)(19627235002)(316002)(76116006)(54906003)(8676002)(55236004)(4326008)(6916009)(71200400001)(2906002)(186003)(86362001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Mpb8pstP/kzhF9im8AZvoHBneBSFoJ5kpmZeVmNGVHXKPCFDRJHW31l/7r?=
 =?iso-8859-1?Q?ApdDFSK6U+bWrU910iYYwvonMGhmpfQKQD2IQ1F4NbSJ81W0ucTRBJSRQC?=
 =?iso-8859-1?Q?SrExTKelqtkGnaxjPMEL31y8fC9cDEBRRdCrjANyuWxzpX06JbXs6LuGSm?=
 =?iso-8859-1?Q?B9E/xn+CCt8sW6SUurioQ0ZWblVZenARXp+Amc+sOEgacaOKD5WUPvren0?=
 =?iso-8859-1?Q?RiefP8+r1EKtu2QBuMV7tyyeKkI48b0JPJk2dcYQswwV8VBv7e99in0CHZ?=
 =?iso-8859-1?Q?NCw4ADRTL5DAVtxZlX0EySqwFIc421FLgsm7DWR0GzDwccGYjGbgb/p6m0?=
 =?iso-8859-1?Q?OoAmIeg01Kx3ShQqaeYOeI/aCM+C8GVZ2lt1ERSKpy6XPHFiKyMKTk4WTU?=
 =?iso-8859-1?Q?y44awmDXnKDcAvS1Yx+BvW527zNXytM0xujSLGeBDUI2euZR/stiSW4T77?=
 =?iso-8859-1?Q?aX361D+3Rl11+3YyG69qp7ZtGc8PbjXqxAAE1C7Ps/HY/qerUJSUSU5FMF?=
 =?iso-8859-1?Q?fHbMQgnTY8hNk9b/Q/euCdP/TaNyTPE8kv047aV6wzNx2GApuO2b3/N8e2?=
 =?iso-8859-1?Q?ZECzDxYN5tOTIVqjoqjzpm1/1DZGEZzE6wwwWAOu5ENmYfTfFSOWQuBMlm?=
 =?iso-8859-1?Q?eFD+HQXREJkvm1z4Hp/c46Yupa/uGQh4cP/d68Y13x8JR1jTfAPB4tlbkn?=
 =?iso-8859-1?Q?8+k5fNkTHfeJ7QKsXvRFHLq6dZXb9wIZqRGl+toH5Zq0u+28Y27g4Usyu7?=
 =?iso-8859-1?Q?i9nx+SHlX/W04RGQMBpqNs7uch2dSfTTla+UqdQ7tlrHkDVK0zcxTAjSvg?=
 =?iso-8859-1?Q?R3vkP7e84bqvbjZllVAuwH32n/lRImLXOUU7bRdMMTJa+7mjHJStDTgrFx?=
 =?iso-8859-1?Q?pKzZjVyWoyztGRClgpd+iEiR3nDUgUdctYIbB+ndCQKEPhJLeKRaS3zHv6?=
 =?iso-8859-1?Q?opysa652NMl6vQV2p66z/o1MJjKDagITK/b0t+fjK53g2doTnw+AhyFs7H?=
 =?iso-8859-1?Q?PnQllMnJlPC66pm/9KSYhuuQ2zvjI5ODFSs/ogUUAU7fvQvL8OMr/iEAQ8?=
 =?iso-8859-1?Q?EwnVbDwEiOfElm0JHmlw2oRGouzuNzJqC5u7Qeis95RpMVnT6TFVuq0vRD?=
 =?iso-8859-1?Q?pJfNMtmY/INE1/VJ66i5YQtd9Y8GzrbfXjdY3UK4aIztaL4mioDLgalcdv?=
 =?iso-8859-1?Q?hDjJaTdqRxakOvZ1kblI6jqxszqP3m4zETO93q+Rom8dARE2GQ76mLk9li?=
 =?iso-8859-1?Q?wqAA1PJ7/SnQeI9QEVmRt0eT/ltp4tAvli5wgNDux4DyG62lNnn6k/3j7Y?=
 =?iso-8859-1?Q?Cg7/2EwpDrMblziLqA88c4g/UgISpiVlQJE0Lr59YQPHA60vwcq/b5ukin?=
 =?iso-8859-1?Q?0ztfTG/GZnOfK08ZayhrftRW80o6UA+DacpSd3GhXMPfu+PSvniIaYI7/7?=
 =?iso-8859-1?Q?UYVqEAldeWAoBV1y5hKqX26swCVbvDfZWrxSGZgMrjsiI6VhB2aU3vENEG?=
 =?iso-8859-1?Q?HrVauB+QRyvuH9j47gkNR9HMQWWLRgVzUsi2DqrsME0vji4YtqtUXmYZGb?=
 =?iso-8859-1?Q?6GV0Qw2sBAgZ38zPccwx1G4oAOt6Jal3YjdTh7mAuYnOvt3ufMCgPWeHlv?=
 =?iso-8859-1?Q?Ds9mT1X+Awfv/VQO99BYTwhDaApOe9g/ItdBgMPSB4C+RCyuL0GE4eHs02?=
 =?iso-8859-1?Q?boRTmo59J7J+WnM4PwUxr3t2N2Bt6i4dUNc8tFLRXgz33+I/VZ3yFVdwvH?=
 =?iso-8859-1?Q?9K9NjK2OZTm1K694NEt6lWI2wj2R19RMPAb5OmZ5YNuBWZSTOIYF/ZHzxk?=
 =?iso-8859-1?Q?BcAKJZ/fsJ/eoIsfCsqxePZY9SfL8io=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440d8bd7-203d-48d5-9984-08da30e2f7c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2022 11:07:40.3829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AdDaiLjFBgOyhs5BRMldzPVTJoKbw/Z2pLNMBghjQOVe7zYQv9WYYelVf/q1Fxn/hlYYOB7VN7m6rbu7RQCu+cY0HawsWuEEaSU3AgPDfYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB8121
X-Proofpoint-GUID: LOjLwSpttGyITRMndtIkIh4yInKcWmkK
X-Proofpoint-ORIG-GUID: LOjLwSpttGyITRMndtIkIh4yInKcWmkK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_03,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205080074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hello Bjorn,

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Sat, May 07, 2022 at 10:22:32AM +0000, Volodymyr Babchuk wrote:
>> Bjorn Helgaas <helgaas@kernel.org> writes:
>> > On Wed, May 04, 2022 at 07:56:01PM +0000, Volodymyr Babchuk wrote:
>> >>=20
>> >> I have encountered issue when PCI code tries to use both fields in
>> >>=20
>> >>         union {
>> >> 		struct pci_sriov	*sriov;		/* PF: SR-IOV info */
>> >> 		struct pci_dev		*physfn;	/* VF: related PF */
>> >> 	};
>> >>=20
>> >> (which are part of struct pci_dev) at the same time.
>> >>=20
>> >> Symptoms are following:
>> >>=20
>> >> # echo 1 > /sys/bus/pci/devices/0000:01:00.0/sriov_numvfs
>> >>=20
>> >> pci 0000:01:00.2: reg 0x20c: [mem 0x30018000-0x3001ffff 64bit]
>> >> pci 0000:01:00.2: VF(n) BAR0 space: [mem 0x30018000-0x30117fff 64bit]=
 (contains BAR0 for 32 VFs)
>> >>  Unable to handle kernel paging request at virtual address 0001000200=
000010
>
>> >> Debugging showed the following:
>> >>=20
>> >> pci_iov_add_virtfn() allocates new struct pci_dev:
>> >>=20
>> >> 	virtfn =3D pci_alloc_dev(bus);
>> >> and sets physfn:
>> >> 	virtfn->is_virtfn =3D 1;
>> >> 	virtfn->physfn =3D pci_dev_get(dev);
>> >>=20
>> >> then we will get into sriov_init() via the following call path:
>> >>=20
>> >> pci_device_add(virtfn, virtfn->bus);
>> >>   pci_init_capabilities(dev);
>> >>     pci_iov_init(dev);
>> >>       sriov_init(dev, pos);
>> >
>> > We called pci_device_add() with the VF.  pci_iov_init() only calls
>> > sriov_init() if it finds an SR-IOV capability on the device:
>> >
>> >   pci_iov_init(struct pci_dev *dev)
>> >     pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
>> >     if (pos)
>> >       return sriov_init(dev, pos);
>> >
>> > So this means the VF must have an SR-IOV capability, which sounds a
>> > little dubious.  From PCIe r6.0:
>>=20
>> [...]
>>=20
>> Yes, I dived into debugging and came to the same conclusions. I'm still
>> investigating this, but looks like my PCIe controller (DesignWare-based)
>> incorrectly reads configuration space for VF. Looks like instead of
>> providing access VF config space, it reads PF's one.
>>=20
>> > Can you supply the output of "sudo lspci -vv" for your system?
>>=20
>> Sure:
>>=20
>> root@spider:~# lspci -vv
>> 00:00.0 PCI bridge: Renesas Technology Corp. Device 0031 (prog-if 00 [No=
rmal decode])
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR+ FastB2B- DisINTx+
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=
 <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 0
>>         Interrupt: pin A routed to IRQ 189
>>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=
=3D0
>>         I/O behind bridge: [disabled]
>>         Memory behind bridge: 30000000-301fffff [size=3D2M]
>>         Prefetchable memory behind bridge: [disabled]
>>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=
 <TAbort- <MAbort- <SERR- <PERR-
>>         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- Fast=
B2B-
>>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>         Capabilities: [40] Power Management version 3
>>                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0+,D1+=
,D2-,D3hot+,D3cold+)
>>                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PM=
E-
>>         Capabilities: [50] MSI: Enable+ Count=3D128/128 Maskable+ 64bit+
>>                 Address: 0000000004030040  Data: 0000
>>                 Masking: fffffffe  Pending: 00000000
>>         Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
>>                 DevCap: MaxPayload 256 bytes, PhantFunc 0
>>                         ExtTag+ RBE+
>>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>>                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr=
+ TransPend-
>>                 LnkCap: Port #0, Speed 5GT/s, Width x2, ASPM L0s L1, Exi=
t Latency L0s <4us, L1 <64us
>>                         ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp+
>>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                 LnkSta: Speed 5GT/s (ok), Width x2 (ok)
>>                         TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt=
-
>>                 RootCap: CRSVisible-
>>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntE=
na+ CRSVisible-
>>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis+,=
 NROPrPrP+, LTR+
>>                          10BitTagComp+, 10BitTagReq-, OBFF Not Supported=
, ExtFmt-, EETLPPrefix-
>>                          EmergencyPowerReduction Not Supported, Emergenc=
yPowerReductionInit-
>>                          FRS-, LN System CLS Not Supported, TPHComp-, Ex=
tTPHComp-, ARIFwd-
>>                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, =
LTR+, OBFF Disabled ARIFwd-
>>                          AtomicOpsCtl: ReqEn- EgressBlck-
>>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Spee=
dDis-
>>                          Transmit Margin: Normal Operating Range, EnterM=
odifiedCompliance- ComplianceSOS-
>>                          Compliance De-emphasis: -6dB
>>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationCo=
mplete-, EqualizationPhase1-
>>                          EqualizationPhase2-, EqualizationPhase3-, LinkE=
qualizationRequest-
>>         Capabilities: [100 v2] Advanced Error Reporting
>>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmpl=
t- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmpl=
t- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmpl=
t- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNo=
nFatalErr-
>>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNo=
nFatalErr+
>>                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- =
ECRCChkCap- ECRCChkEn-
>>                         MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogC=
ap-
>>                 HeaderLog: 00000000 00000000 00000000 00000000
>>                 RootCmd: CERptEn- NFERptEn- FERptEn-
>>                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>>                          FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
>>                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>>         Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00=
-00
>>         Capabilities: [158 v1] Secondary PCI Express
>>                 LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
>>                 LaneErrStat: 0
>>         Capabilities: [178 v1] Physical Layer 16.0 GT/s <?>
>>         Capabilities: [19c v1] Lane Margining at the Receiver <?>
>>         Capabilities: [1bc v1] L1 PM Substates
>>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1=
+ L1_PM_Substates+
>>                           PortCommonModeRestoreTime=3D10us PortTPowerOnT=
ime=3D14us
>>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.=
1+
>>                            T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
>>                 L1SubCtl2: T_PwrOn=3D10us
>>         Capabilities: [1cc v1] Vendor Specific Information: ID=3D0002 Re=
v=3D4 Len=3D100 <?>
>>         Capabilities: [2cc v1] Vendor Specific Information: ID=3D0001 Re=
v=3D1 Len=3D038 <?>
>>         Capabilities: [304 v1] Data Link Feature <?>
>>         Capabilities: [310 v1] Precision Time Measurement
>>                 PTMCap: Requester:+ Responder:+ Root:+
>>                 PTMClockGranularity: 16ns
>>                 PTMControl: Enabled:- RootSelected:-
>>                 PTMEffectiveGranularity: Unknown
>>         Capabilities: [31c v1] Vendor Specific Information: ID=3D0004 Re=
v=3D1 Len=3D054 <?>
>>         Kernel driver in use: pcieport
>>         Kernel modules: pci_endpoint_test
>>=20
>> 01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Devic=
e a824 (prog-if 02 [NVM Express])
>>         Subsystem: Samsung Electronics Co Ltd Device a809
>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParE=
rr- Stepping- SERR- FastB2B- DisINTx+
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=
 <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 0
>>         Interrupt: pin A routed to IRQ 0
>>         NUMA node: 0
>>         Region 0: Memory at 30010000 (64-bit, non-prefetchable) [size=3D=
32K]
>>         Expansion ROM at 30000000 [virtual] [disabled] [size=3D64K]
>>         Capabilities: [40] Power Management version 3
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-=
,D2-,D3hot-,D3cold-)
>>                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PM=
E-
>>         Capabilities: [70] Express (v2) Endpoint, MSI 00                =
                                                                           =
                                    [8/5710]
>>                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s u=
nlimited, L1 unlimited
>>                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ =
SlotPowerLimit 0.000W
>>                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLR=
eset-
>>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr=
- TransPend-
>>                 LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM not suppor=
ted
>>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                 LnkSta: Speed 5GT/s (downgraded), Width x2 (downgraded)
>>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt=
-
>>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, NR=
OPrPrP-, LTR-
>>                          10BitTagComp+, 10BitTagReq-, OBFF Not Supported=
, ExtFmt-, EETLPPrefix-
>>                          EmergencyPowerReduction Not Supported, Emergenc=
yPowerReductionInit-
>>                          FRS-, TPHComp-, ExtTPHComp-
>>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, =
LTR-, OBFF Disabled
>>                          AtomicOpsCtl: ReqEn-
>>                 LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- Spe=
edDis-
>>                          Transmit Margin: Normal Operating Range, EnterM=
odifiedCompliance- ComplianceSOS-
>>                          Compliance De-emphasis: -6dB
>>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationCo=
mplete-, EqualizationPhase1-
>>                          EqualizationPhase2-, EqualizationPhase3-, LinkE=
qualizationRequest-
>>         Capabilities: [b0] MSI-X: Enable+ Count=3D64 Masked-
>>                 Vector table: BAR=3D0 offset=3D00004000
>>                 PBA: BAR=3D0 offset=3D00003000
>>         Capabilities: [100 v2] Advanced Error Reporting
>>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmpl=
t- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmpl=
t- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmpl=
t- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNo=
nFatalErr-
>>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNo=
nFatalErr+
>>                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- =
ECRCChkCap+ ECRCChkEn-
>>                         MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogC=
ap-
>>                 HeaderLog: 00000000 00000000 00000000 00000000
>>         Capabilities: [148 v1] Device Serial Number d3-42-50-11-99-38-25=
-00
>>         Capabilities: [168 v1] Alternative Routing-ID Interpretation (AR=
I)
>>                 ARICap: MFVC- ACS-, Next Function: 0
>>                 ARICtl: MFVC- ACS-, Function Group: 0
>>         Capabilities: [178 v1] Secondary PCI Express
>>                 LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
>>                 LaneErrStat: 0
>>         Capabilities: [198 v1] Physical Layer 16.0 GT/s <?>
>>         Capabilities: [1c0 v1] Lane Margining at the Receiver <?>
>>         Capabilities: [1e8 v1] Single Root I/O Virtualization (SR-IOV)
>>                 IOVCap: Migration-, Interrupt Message Number: 000
>>                 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy-
>>                 IOVSta: Migration-
>>                 Initial VFs: 32, Total VFs: 32, Number of VFs: 0, Functi=
on Dependency Link: 00
>>                 VF offset: 2, stride: 1, Device ID: a824
>>                 Supported Page Size: 00000553, System Page Size: 0000000=
1
>>                 Region 0: Memory at 0000000030018000 (64-bit, non-prefet=
chable)
>>                 VF Migration: offset: 00000000, BIR: 0
>>         Capabilities: [3a4 v1] Data Link Feature <?>
>>         Kernel driver in use: nvme
>>         Kernel modules: nvme
>
> I guess this is before enabling SR-IOV on 01:00.0, so it doesn't show
> the VFs themselves.

Yes. Because kernel crashed without your suggested patch.

>> > It could be that the device has an SR-IOV capability when it
>> > shouldn't.  But even if it does, Linux could tolerate that better
>> > than it does today.
>>=20
>> Agree there. I can create simple patch that checks for is_virtfn
>> in sriov_init(). But what to do if it is set?
>
> Maybe something like this?  It makes no sense to me that a VF would
> have an SR-IOV capability, but ...
>
> If the below avoids the problem, maybe collect another "lspci -vv"
> output including the VF(s).
>

I had another crash in nvme_pci_enable(), for which I made quick
workaround. And now yeah, it looks like I have some issues with
my root complex HW:

[skipping bridge info]

01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a=
824 (prog-if 02 [NVM Express])
        Subsystem: Samsung Electronics Co Ltd Device a809
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 0
        NUMA node: 0
        Region 0: Memory at 30010000 (64-bit, non-prefetchable) [size=3D32K=
]
        Expansion ROM at 30000000 [virtual] [disabled] [size=3D64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
                Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s unli=
mited, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ Slo=
tPowerLimit 0.000W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLRese=
t-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- T=
ransPend-
                LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM not supported
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (downgraded), Width x2 (downgraded)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, NROPr=
PrP-, LTR-
                         10BitTagComp+, 10BitTagReq-, OBFF Not Supported, E=
xtFmt-, EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPo=
werReductionInit-
                         FRS-, TPHComp-, ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
-, OBFF Disabled
                         AtomicOpsCtl: ReqEn-
                LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedD=
is-
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [b0] MSI-X: Enable- Count=3D64 Masked-
                Vector table: BAR=3D0 offset=3D00004000
                PBA: BAR=3D0 offset=3D00003000
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECR=
CChkCap+ ECRCChkEn-
                        MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [148 v1] Device Serial Number d3-42-50-11-99-38-25-00
        Capabilities: [168 v1] Alternative Routing-ID Interpretation (ARI)
                ARICap: MFVC- ACS-, Next Function: 0
                ARICtl: MFVC- ACS-, Function Group: 0
        Capabilities: [178 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
                LaneErrStat: 0
        Capabilities: [198 v1] Physical Layer 16.0 GT/s <?>
        Capabilities: [1c0 v1] Lane Margining at the Receiver <?>
        Capabilities: [1e8 v1] Single Root I/O Virtualization (SR-IOV)
                IOVCap: Migration-, Interrupt Message Number: 000
                IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy-
                IOVSta: Migration-
                Initial VFs: 32, Total VFs: 32, Number of VFs: 1, Function =
Dependency Link: 00
                VF offset: 2, stride: 1, Device ID: a824
                Supported Page Size: 00000553, System Page Size: 00000001
                Region 0: Memory at 0000000030018000 (64-bit, non-prefetcha=
ble)
                VF Migration: offset: 00000000, BIR: 0
        Capabilities: [3a4 v1] Data Link Feature <?>
        Kernel driver in use: nvme
        Kernel modules: nvme

01:00.2 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a=
824 (prog-if 02 [NVM Express])
        Subsystem: Samsung Electronics Co Ltd Device a809
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 0
        NUMA node: 0
        Region 0: Memory at 30018000 (64-bit, non-prefetchable) [size=3D32K=
]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s unli=
mited, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ Slo=
tPowerLimit 0.000W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLRese=
t-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- T=
ransPend-
                LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM not supported
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (downgraded), Width x2 (downgraded)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, NROPr=
PrP-, LTR-
                         10BitTagComp+, 10BitTagReq-, OBFF Not Supported, E=
xtFmt-, EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPo=
werReductionInit-
                         FRS-, TPHComp-, ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
-, OBFF Disabled
                         AtomicOpsCtl: ReqEn-
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [b0] MSI-X: Enable- Count=3D64 Masked-
                Vector table: BAR=3D0 offset=3D00004000
                PBA: BAR=3D0 offset=3D00003000
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECR=
CChkCap+ ECRCChkEn-
                        MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [148 v1] Device Serial Number d3-42-50-11-99-38-25-00
        Capabilities: [168 v1] Alternative Routing-ID Interpretation (ARI)
                ARICap: MFVC- ACS-, Next Function: 0
                ARICtl: MFVC- ACS-, Function Group: 0
        Capabilities: [178 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
                LaneErrStat: 0
        Capabilities: [198 v1] Physical Layer 16.0 GT/s <?>
        Capabilities: [1c0 v1] Lane Margining at the Receiver <?>
        Capabilities: [1e8 v1] Single Root I/O Virtualization (SR-IOV)
                IOVCap: Migration-, Interrupt Message Number: 000
                IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy-
                IOVSta: Migration-
                Initial VFs: 32, Total VFs: 32, Number of VFs: 1, Function =
Dependency Link: 00
                VF offset: 2, stride: 1, Device ID: a824
                Supported Page Size: 00000553, System Page Size: 00000001
                Region 0: Memory at 0000000030018000 (64-bit, non-prefetcha=
ble)
                VF Migration: offset: 00000000, BIR: 0
        Capabilities: [3a4 v1] Data Link Feature <?>
        Kernel modules: nvme

As you can see, output for func 0 and func 2 is identical, so yeah,
looks like my system reads config space for func 0 in both cases.

Now at least I know where to look. Thank you for your help.

> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 952217572113..9c5184384a45 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -901,6 +901,10 @@ int pci_iov_init(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return -ENODEV;
> =20
> +	/* Some devices include SR-IOV cap on VFs as well as PFs */
> +	if (dev->is_virtfn)
> +		return -ENODEV;
> +
>  	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
>  	if (pos)
>  		return sriov_init(dev, pos);

Thanks, this patch helped. You can have my

Tested-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

if you are going to include it in the kernel.

On other hand, I'm wondering if it is correct to have both is_virtfn and
is_physfn in the first place, as there can 4 combinations and only two
(or three?) of them are valid. Maybe it is worth to replace them with
enum?

--=20
Volodymyr Babchuk at EPAM=
