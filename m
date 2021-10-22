Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7A5437540
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 12:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhJVKKs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 06:10:48 -0400
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:19574 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231944AbhJVKKr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 06:10:47 -0400
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MA28uZ031396;
        Fri, 22 Oct 2021 10:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=com20210415pp;
 bh=519XfDyJd9EM3NLrrYB4edsc5FaMHS4NWXqZ/UkqtVw=;
 b=xyGL2PDtqDjTsx8fyXxIXYhnGRq37OIvCr19yDzfDeccDl9JPgY5Fhw1RL6QOcgNCjCb
 bRbNq/SWjYqtQAmlRDDw16hZaWl0T1SrV3N2nlLmyP5kuffkFEgq5PWLu7pF569qGZ32
 T+c+sypkmpgL0E/RfCEsyurH6IEtHBq9ejiWSx9acYvn1nX2Zh4yqjkBqMst0kcFc6OR
 vDfTE5TXh1u9ZCICVr2WThx/1hnxfv2QAfpBZv3VFyL1PeTZeZNJ/sw6v2I+wa22sMZe
 RMXaQOr+IPrpMjIb1+hMJHK2u6g/9+ofZuh89Q00qyou+P7hljrHNYFB/ufxvNon63Ev Dw== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by mx0a-00622301.pphosted.com with ESMTP id 3bucv2gcws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:08:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOCpmADw5dKMhP8m9RR+A8dtADLxKjUnoH3AbH1o17s+E3gzilgfxp24pf2V6ZGYnTr+clQ0DbIe14iQy/3VfPXdLJFs1x45ciJc9JzrTBczuVfSpgtveeIBdKj3XELRiEFWwxokAI/HnVCiDgEbm64h1T6rfsCiEqG3P+qonIP/HPdglBjgGpQGAIQGogSt50wPr3CPJxljwsZVnazBEDOnOscpdlVXb03iXgAIXL87hZTOq4FqB2pnOn1WTgwg3NM0AZq1jE9pZwVNCPa4z2fjnY2XkkwQ6qLvLEh20pQWo4DpbE4qPhhq+/LJeGVkFLNk9Whkbu7SGJa2HIWmdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piTPCIc9LDfgnDTuZEnPB36krEcN8F29UTNelRYO0kE=;
 b=KiJ7OZ3TvPZ5w6/J4/bYr3fZTw2Rxdpu4V3MPPXe/GTk0anAzM5j+pld8fQHlBYQ7mAJaqILwT2wbbM8NewYgMOvQkL2wm37Q+a/8DhnmHMv82ETie3VT1PQsHOkuFjlkmGi7ZdPIpr6KBTj1dW9Mwh8wrKNfeoUkm3P2ZvBaIc9m0MMkjh45AizhuWfbFMbRldGzGg8IbfXtJuGHxI0AutE4ls+ewJfYCNQs5THX/dj9jBp+3wp+VX7XQrlMPPDH/9SLMalL2jYqRj9+T+Ee/+RnCJtzfWVCpOG/jqXw30qMHFPb3TiFQkg8Hb6GGZqZGRy5BcISmNANj7wdQhUdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piTPCIc9LDfgnDTuZEnPB36krEcN8F29UTNelRYO0kE=;
 b=cSnuqHMCU7WWZDSfmLZxrZ0UBIpsWULYnjINghVmVFZBSmdBtZNTSqn3rIqcAbdo6IZBnIAd7dDMjyPF/qDbRliheeUl8UX4Y8eLzGg05QSHt2J6wRw0sgnZy+x9gbq5rTgsfi03cQE8zl+7PnTKUsWhzfa59Q4IV4hXTXiDx0s=
Received: from CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22)
 by CH2PR19MB3800.namprd19.prod.outlook.com (2603:10b6:610:95::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Fri, 22 Oct
 2021 10:08:20 +0000
Received: from CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7]) by CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7%5]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 10:08:20 +0000
From:   Li Chen <lchen@ambarella.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: nvme may get timeout from dd when using different non-prefetch mmio
 outbound/ranges
Thread-Topic: nvme may get timeout from dd when using different non-prefetch
 mmio outbound/ranges
Thread-Index: AdfHKUVD4pdAQATdSnyIoo960S9VyQ==
Date:   Fri, 22 Oct 2021 10:08:20 +0000
Message-ID: <CH2PR19MB4024E04EBD0E4958F0BBB2ACA0809@CH2PR19MB4024.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=ambarella.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8624d680-e83e-4e56-4c38-08d99543e00e
x-ms-traffictypediagnostic: CH2PR19MB3800:
x-microsoft-antispam-prvs: <CH2PR19MB38006451BF5185649D7248D3A0809@CH2PR19MB3800.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hTlOLktgXku/+iX4tDw7XvbJrY74TENZ+Xp+bx/DU1uN7f7bkWAzvrWEqCXVGFmUhDkRAZSmDpFYqnM6NxXWi0KMnShhhjQ3twIStZBP5eCuVcregU27qJC3JRlqNUBexAT/2cFaJAmXuVfRKk5j/A5f/54BPQn2zoCHybgpZcgexK9ojqFi4JkfYTb8/xoIpIQI3TV3f7pu+ARKJlHFYHHM7xnKSsKeojv+51Gut75951nQnOj7mifkVHniJ/X6991S/Re1FU98q+wnsJXvWCIHF7rpT0CwtJvQ/wmozA00I0tV9h0Vlp/Dj8cfa0bE4LyW6c+vC1yN5SEWlZvvUyJH0GRCNEUnsh6zuVguE9tV9ZPfBA+eAdrxuBBOht6NP52VfVu/rKbgDZlfpDD0Hgzb4fuStTDwKSt9j04oea+Aa++8QMs+ayY127tkjHhIfeKYRbLQPEn2yKuG6Dbqw2Pvud23zSArboF5iT401va9QtYYP4h46y5PaaN4h39LtZqFJ2zYMe2UcmNuCi6f/C98ghYLsbMlcWjPbo5QUOXFp0E6+BXj+eYPP+edLlVnn2hCp3cdBalxCqJYIyqse4x+vqeNEkStJFF/RFRYoR7zmUHPnYl/RqYjHxvSCLCHeVnszKI6CS80PB5MU8lkZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB4024.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(38100700002)(122000001)(8936002)(64756008)(55016002)(83380400001)(88996005)(66446008)(66476007)(71200400001)(66946007)(66556008)(86362001)(33656002)(4326008)(9686003)(6916009)(316002)(7696005)(186003)(26005)(6506007)(54906003)(5660300002)(52536014)(8676002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vtLQz/fOf3mlEaLnsNovojxSIy532+lQutgF1+YcWTYqQnu4GAjUaeVUL5M4?=
 =?us-ascii?Q?2t2BckHFGXcC76+NJ+mNVPDWk6JYTI42+2kdolP/gYvD9zHh2msuBEGbLj7d?=
 =?us-ascii?Q?Ip0XHdVyZygeKS97IRPpEq/t1sht5MW5ZASRmFjpupjez7JGqfGe+cfKwRZH?=
 =?us-ascii?Q?2xMvgstGRJQK0CMAZ+B790ao+1xFW8oQspCUgWBlOFEMSQCRBXM+OF0i8Qtf?=
 =?us-ascii?Q?VQv8pJJJWoRZbEu/6rw3RgI3bkWIONLzlYow9pJNjVQOZpGpdWMJS89cKo5S?=
 =?us-ascii?Q?12PwXE8r7EsS2/ZbO9K2ShLy46WiH0vrgvjTiRLA6EZKyYy2GC16CU0iNICf?=
 =?us-ascii?Q?A9P+nMIYH8IVZ1tx3C8l8/bvLnli5inMjvdkCcKp5GXGSAjps3DiDL1X0AS0?=
 =?us-ascii?Q?Q+ev4lc73tJd5QhNweDwz3cvvmJLEVmQxOo6JCRpCyeOYEc4KaNjjfNB+GQ8?=
 =?us-ascii?Q?tjMdrpcjFZeJHZAA1vJjIUb1OxFl2b/n8w1M+jwK8Qpqn4dd9IUTA8Cd/pax?=
 =?us-ascii?Q?/IGldgIBuGjSUGThOongPVU820qn3dR2uJbkcX7hfMmn0W4gNBDD9d+nrQX5?=
 =?us-ascii?Q?FLP3VGFnQ5wF30ijbhYN1As+/MR5chNNKadQaWnKzcnLdfresY+GTnWHeMfn?=
 =?us-ascii?Q?A9GSSX59NU2gVvcioOhCduPvvZ0Gh9aYa+F0IxKRvOHFIApnqGfZtD8/ZZG2?=
 =?us-ascii?Q?o8fiXjxrGGyrK0XkisY8uyFhqacq5dfL0vbFNEy9G3BMI8p7hX8db/PA+0h6?=
 =?us-ascii?Q?c5CpNzwoTR8kTOraawH4EqNYyZ+4tT9eaYgxFkApY/AOgy+l0bDTZuLqHIqe?=
 =?us-ascii?Q?aVqZ/rYcLHrcChvfxDfxXLVLdR/c5yLu4b3MpHuVlBdQwuTPSFy9FCODYgro?=
 =?us-ascii?Q?E17GPzL/bN9p0w6QeJiVDbcis0ibwK77DxApuJU7UO1mVkXz4AGqtaKJgzNY?=
 =?us-ascii?Q?LM03Pyv0roFqLFehitU9SeFCahoN3nXb6zHIZ+CxUAMr/IbMegGLPblo6bJL?=
 =?us-ascii?Q?KQNPy5hip9K6v+FKeS4mR+a/AiShoZSTiI2ERWbDGAMSW0bM5J8iNzE2Q+hL?=
 =?us-ascii?Q?Fv42bIwoZK/0QBd9ZLZL4AS6FPCsDuGHW1Xh63WYcE4gygtUKjf2RGwdA/OU?=
 =?us-ascii?Q?wLJqSH95PHjcTNEnBBbLTmCzUinG2kAp9X4Cpi//rSCvgNbcPlkdBKXQOpB8?=
 =?us-ascii?Q?dBMaUPniIOVm+zdPaj90O4y/7e/GjDVn+Qn5FckicihM2ju0qdMPDI/KC4mp?=
 =?us-ascii?Q?1ifepDh8r50rQsSqqzgbuV4P1ojReBxydi4Ykj/5ooj1fm80Iw7K1mNNuCnf?=
 =?us-ascii?Q?Lt16OOUGwk08fKFSlEhFhxa64qfBRrVEa/nsfyrILH6A9/M/a0uNQKGLrXAb?=
 =?us-ascii?Q?f9OjJAZBb+3KMX++nCWJdLSvqRxsRjtdVKLouM3nn0kGsg/nb/PnfC1CVf1p?=
 =?us-ascii?Q?ZJaUf7OLh7o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB4024.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8624d680-e83e-4e56-4c38-08d99543e00e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 10:08:20.1876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lchen@ambarella.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3800
X-Proofpoint-GUID: UtEGxpOopJrfO7qy-moRf8vg2XBHUuV-
X-Proofpoint-ORIG-GUID: UtEGxpOopJrfO7qy-moRf8vg2XBHUuV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_03,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=782 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220056
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, all

I found my nvme may get timeout with simply dd, the pcie controller is cade=
nce, and the pcie-controller platform I use is pcie-cadence-host.c, kenrel =
version is 5.10.32:

# dd if=3D/dev/urandom of=3D/dev/nvme0n1 bs=3D4k count=3D1024000
[   41.913484][  T274] urandom_read: 2 callbacks suppressed
[   41.913490][  T274] random: dd: uninitialized urandom read (4096 bytes r=
ead)
[   41.926130][  T274] random: dd: uninitialized urandom read (4096 bytes r=
ead)
[   41.933348][  T274] random: dd: uninitialized urandom read (4096 bytes r=
ead)
[   47.651842][    C0] random: crng init done
[   47.655963][    C0] random: 2 urandom warning(s) missed due to ratelimit=
ing
[   81.448128][   T64] nvme nvme0: controller is down; will reset: CSTS=3D0=
x3, PCI_STATUS=3D0x2010
[   81.481139][    T7] nvme 0000:05:00.0: enabling bus mastering
[   81.486946][    T7] nvme 0000:05:00.0: saving config space at offset 0x0=
 (reading 0xa809144d)
[   81.495517][    T7] nvme 0000:05:00.0: saving config space at offset 0x4=
 (reading 0x20100006)
[   81.504091][    T7] nvme 0000:05:00.0: saving config space at offset 0x8=
 (reading 0x1080200)
[   81.512571][    T7] nvme 0000:05:00.0: saving config space at offset 0xc=
 (reading 0x0)
[   81.520527][    T7] nvme 0000:05:00.0: saving config space at offset 0x1=
0 (reading 0x8000004)
[   81.529094][    T7] nvme 0000:05:00.0: saving config space at offset 0x1=
4 (reading 0x0)
[   81.537138][    T7] nvme 0000:05:00.0: saving config space at offset 0x1=
8 (reading 0x0)
[   81.545186][    T7] nvme 0000:05:00.0: saving config space at offset 0x1=
c (reading 0x0)
[   81.553252][    T7] nvme 0000:05:00.0: saving config space at offset 0x2=
0 (reading 0x0)
[   81.561296][    T7] nvme 0000:05:00.0: saving config space at offset 0x2=
4 (reading 0x0)
[   81.569340][    T7] nvme 0000:05:00.0: saving config space at offset 0x2=
8 (reading 0x0)
[   81.577384][    T7] nvme 0000:05:00.0: saving config space at offset 0x2=
c (reading 0xa801144d)
[   81.586038][    T7] nvme 0000:05:00.0: saving config space at offset 0x3=
0 (reading 0x0)
[   81.594081][    T7] nvme 0000:05:00.0: saving config space at offset 0x3=
4 (reading 0x40)
[   81.602217][    T7] nvme 0000:05:00.0: saving config space at offset 0x3=
8 (reading 0x0)
[   81.610266][    T7] nvme 0000:05:00.0: saving config space at offset 0x3=
c (reading 0x12c)
[   81.634065][    T7] nvme nvme0: Shutdown timeout set to 8 seconds
[   81.674332][    T7] nvme nvme0: 1/0/0 default/read/poll queues
[  112.168136][  T256] nvme nvme0: I/O 12 QID 1 timeout, disable controller
[  112.193145][  T256] blk_update_request: I/O error, dev nvme0n1, sector 6=
00656 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
[  112.205220][  T256] Buffer I/O error on dev nvme0n1, logical block 75082=
, lost async page write
[  112.213978][  T256] Buffer I/O error on dev nvme0n1, logical block 75083=
, lost async page write
[  112.222727][  T256] Buffer I/O error on dev nvme0n1, logical block 75084=
, lost async page write
[  112.231474][  T256] Buffer I/O error on dev nvme0n1, logical block 75085=
, lost async page write
[  112.240220][  T256] Buffer I/O error on dev nvme0n1, logical block 75086=
, lost async page write
[  112.248966][  T256] Buffer I/O error on dev nvme0n1, logical block 75087=
, lost async page write
[  112.257719][  T256] Buffer I/O error on dev nvme0n1, logical block 75088=
, lost async page write
[  112.266467][  T256] Buffer I/O error on dev nvme0n1, logical block 75089=
, lost async page write
[  112.275213][  T256] Buffer I/O error on dev nvme0n1, logical block 75090=
, lost async page write
[  112.283959][  T256] Buffer I/O error on dev nvme0n1, logical block 75091=
, lost async page write
[  112.293554][  T256] blk_update_request: I/O error, dev nvme0n1, sector 6=
01672 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
[  112.306559][  T256] blk_update_request: I/O error, dev nvme0n1, sector 6=
02688 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
[  112.319525][  T256] blk_update_request: I/O error, dev nvme0n1, sector 6=
03704 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
[  112.332501][  T256] blk_update_request: I/O error, dev nvme0n1, sector 6=
04720 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
[  112.345466][  T256] blk_update_request: I/O error, dev nvme0n1, sector 6=
05736 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
[  112.358427][  T256] blk_update_request: I/O error, dev nvme0n1, sector 6=
06752 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
[  112.371386][  T256] blk_update_request: I/O error, dev nvme0n1, sector 6=
07768 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
[  112.384346][  T256] blk_update_request: I/O error, dev nvme0n1, sector 6=
08784 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
[  112.397315][  T256] blk_update_request: I/O error, dev nvme0n1, sector 6=
09800 op 0x1:(WRITE) flags 0x104000 phys_seg 127 prio class 0
[  112.459313][    T7] nvme nvme0: failed to mark controller live state
[  112.465758][    T7] nvme nvme0: Removing after probe failure status: -19
dd: error writing '/dev/nvme0n1': No space left on device
112200+0 records in
112199+0 records out
459567104 bytes (438.3MB) copied, 70.573266 seconds, 6.2MB/s
# [  112.935768][    T7] nvme nvme0: failed to set APST feature (-19)




Here is the dts I used:
pciec: pcie-controller@2040000000 {
                                compatible =3D "cdns,cdns-pcie-host";
		device_type =3D "pci";
		#address-cells =3D <3>;
		#size-cells =3D <2>;
		bus-range =3D <0 5>;
		linux,pci-domain =3D <0>;
		cdns,no-bar-match-nbits =3D <38>;
		vendor-id =3D <0x17cd>;
		device-id =3D <0x0100>;
		reg-names =3D "reg", "cfg";
		reg =3D <0x20 0x40000000 0x0 0x10000000>,
		      <0x20 0x00000000 0x0 0x00001000>;	/* RC only */

		/*
		 * type: 0x00000000 cfg space
		 * type: 0x01000000 IO
		 * type: 0x02000000 32bit mem space No prefetch
		 * type: 0x03000000 64bit mem space No prefetch
		 * type: 0x43000000 64bit mem space prefetch
		 * The First 16MB from BUS_DEV_FUNC=3D0:0:0 for cfg space
		 * <0x00000000 0x00 0x00000000 0x20 0x00000000 0x00 0x01000000>, CFG_SPACE
		*/
		ranges =3D <0x01000000 0x00 0x00000000 0x20 0x00100000 0x00 0x00100000>,
			 <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00 0x08000000>;

		#interrupt-cells =3D <0x1>;
		interrupt-map-mask =3D <0x00 0x0 0x0 0x7>;
		interrupt-map =3D <0x0 0x0 0x0 0x1 &gic 0 229 0x4>,
				<0x0 0x0 0x0 0x2 &gic 0 230 0x4>,
				<0x0 0x0 0x0 0x3 &gic 0 231 0x4>,
				<0x0 0x0 0x0 0x4 &gic 0 232 0x4>;
		phys =3D <&pcie_phy>;
		phy-names=3D"pcie-phy";
		status =3D "ok";
	};


After some digging, I find if I change the controller's range property from=
  <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00 0x08000000> into <0x0200=
0000 0x00 0x00400000 0x20 0x00400000 0x00 0x08000000>, then dd will success=
 without timeout. IIUC, range here is only for non-prefetch 32bit mmio, but=
 dd will use dma(maybe cpu will send cmd to nvme controller via mmio?).

Question:
1.  Why dd can cause nvme timeout? Is there more debug ways?
2. How can this mmio range affect nvme timeout?

Regards,
Li

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
