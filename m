Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD84D94F8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 08:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbiCOHBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 03:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbiCOHBd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 03:01:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D632449F10;
        Tue, 15 Mar 2022 00:00:19 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F3E09t015173;
        Tue, 15 Mar 2022 06:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=3hB3h4dIjrPsOOxe0uPeRqer8F5pUyXXoLcjJznlUr4=;
 b=sm52ZdFp8GWwtaa58LwhhLYIvHFir5lM1VBhi6G2sqKWJl4/RnTUaQS/bCRkGOzSI547
 2ySR8naU7T07QWn1v4SmTJOnVnIbQQJiXm9C0PjcrjcMsJTBjn8WOqiyndONaTcXKNjH
 /bGQWh16WFHwci02AA4bOpB2uwap9gg5x9i06qRtjfJC/0D/T/FvGhdj4Z/KBgyjeE5H
 zkzvDxx/xdZ+Xr79xf/Asa9XIqbeq06L7Jh6B2tXzHoJmqVQF4Ohu/KaniA6ppLbbDht
 jCmvdmG1hHkOVkWzAELnmQrBAh6BQj2J697TxJEdSQ/ajn0HPBEBLscba1d2JmxHbJQi AA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rj6xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 06:59:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22F6tpa5007575;
        Tue, 15 Mar 2022 06:59:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3020.oracle.com with ESMTP id 3et64jpbnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 06:59:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFP7NQlUFdmy1parmxZyri/Y77y6ida724iBQz2lHLu2oMa+cKa6RChgTdD1x9cmnuUTsQNCmLP3Rjbpe01CfLD4PiWuPpHQ9tBYjv4vr4Htqjz0GHYq8CXV/5G3MXehxY+zwffX8Yau4pEzgDYVekFevzfmdJxzyaSoacnndVlNd9m8SCSOIoE9pK6Puc5E+vL2yozbMQMgBPTNCexVWnaIZtrvVCWJ38bpEuD+XS5Kba9uHG553cY/ubkYkCsbb/8DOuiG2tvBz/hSP7XLM7v36TeTEgrHjBeui6xvo2k07lwOhD0pOD/z2McrNym7SzLZ4rO7SARhQnMa7aSfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hB3h4dIjrPsOOxe0uPeRqer8F5pUyXXoLcjJznlUr4=;
 b=oGarCkdAGB64t5X5r8qGprdjP0JwfLK14imNYItoW2qPbsrgX5o7M/tXIT4JryL1qbwHnTFl9o3WVENCYMhom6eAosStDN9awz/WCVSMG/B9eISU380jfxf8fM65kqtCEcPGK2tpet9spSvzYOXj7sB4IPWxMsrNN2zr8k5BR1cV4RcmnvwUWddgF+OQgMQhimJ1C/jzZtNZB4NlqLVAZzeXNMLEttAExfNGXoJxU1jTDD3Xg83jR6igeLkRfLCa8qDBeksJA0LSWmqWgfg37hewK1unVvCFy+sGH5KcUpOf5m8aNPqfft6ld+Nu6A1iFmJeuGNh7gq4hCZvopgpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hB3h4dIjrPsOOxe0uPeRqer8F5pUyXXoLcjJznlUr4=;
 b=WN/IlNTRPcHbGBurqVhrP9BYnGDDj5fnakEFXTjcjxbvzuQgEBeggFp19snb5g2X3ymSiBs0j/OKpd+LfATXBLc/vHbirq+EdqeRpwCInXLn3ci5XAZm1I6BiT6TKKUHdB1I5+wFBTsbmdmH5l9JqNSSafNAkBekXeZwVbcfu3I=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4149.namprd10.prod.outlook.com
 (2603:10b6:610:a7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 06:59:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Tue, 15 Mar 2022
 06:59:55 +0000
Date:   Tue, 15 Mar 2022 09:59:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: rockchip: fix find_first_zero_bit() limit
Message-ID: <20220315065944.GB13572@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0188.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 020cdfed-3b95-43db-ab20-08da06516950
X-MS-TrafficTypeDiagnostic: CH2PR10MB4149:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB41499176687BBA75B1B72C238E109@CH2PR10MB4149.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tv64KakBwq15fUEGG+AtOXg20DzIYoLkNmKFbQF6FIX2hjUq7plGlPrPDrhYFBjwJEZpsX6pjKsaRTQj8Mvn/RcMunidGTz1DDuVArjPQRjfBeBeUF6yIDBROGPFASBdtWkijREwCiQU7JMU4Ib5NS77R1sgRUHEAHAIU+Ef677QghjW5fKDg2pA5boXOt7LCnBlZQnF4axG4W8d1Sz0J0R72BEfFZgH6mQWJYSsjHUJBwTPoXzY+pD6Os0/frubssraAGphDKuJI+Rb+9lSOkOI6CQmvMjwVOVJ0aEnSdsfFUlFSD+27+YsB3NnrpzLXbtELDrvmcqF5kQ/cOOtL8CKPoN1SilkECF53PCm4sRNipZc+08N4sPzDDU1PVg4W25hG+wJFZD4iRn7tHSB4tjdMvQ5U2+Zgr17UVYNKc5Wn4qj9xYTUdL3z3X0HNeVpmeZ9OrnNFTcL2WGMsa/V/mAo2NxDmFRTDJ350b1UUxelk5ijgFOojzutHZHRJouFPWYh1JHNdhy+1Am6wFGmIgy0pNuq8ikn2YHSsZJeMMwQmVqh4tps5ccIaTkk6EBKJLkMVOq3soA/k0NUes4M9he0pHK8PSFMmW040OqiVF9yNti41BpiTZ8LcOBX0Cg+1yag7Z7wlKBA5cuW4a13JxuEnXTynjiHyqb2cYjnZE2RHuv2x9w3xwI65ZAEGMgjp6L9sr47h4svnnKDNiMug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(54906003)(316002)(33656002)(66946007)(33716001)(508600001)(8936002)(44832011)(6486002)(4744005)(66476007)(5660300002)(2906002)(38100700002)(38350700002)(8676002)(4326008)(66556008)(86362001)(6666004)(9686003)(1076003)(26005)(6512007)(6506007)(83380400001)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ne+4RzvQIU253qqW29VBef6Emi5OOMV80eZf2h+1qjsYB5RtBcIgxUuDLTsz?=
 =?us-ascii?Q?frS2fdz+xzYwg7VZuROFmv6/Lo6c0YlRVXmAk3KBlkt67staLTdTdp1gQASA?=
 =?us-ascii?Q?ZCvIy+0d44/vIwze9wKVr7sp3OyFe7/QLwtwDc+m/nqvq1X0bRMIpCt/EMri?=
 =?us-ascii?Q?hAHX9XjOtOcxRp+9CYO74TzSAGbFDEbSgOwEm4y/g3CaSW1dhLMNfEFYS85p?=
 =?us-ascii?Q?HkRbCESMS2iau2DnGTO6kSFJPqnBC4No3LG7grLU7UgGLGpwpXVJMJBIraK1?=
 =?us-ascii?Q?cOLPbmDeKcQVrjrJssbrSW4/I9X/NPKsLOhUkCnBUgJWwlXd7It0TFsFqZvX?=
 =?us-ascii?Q?y75oJNy5cJwpnpY2kGsCXPDf5kQmFHDWt02CIyK8wcGlkh31PDUdk0zYCIOd?=
 =?us-ascii?Q?cCXoTogITLgxkJYd6MZhvJ57mkUwmsu4haDMo+B20Jt5psWE6rgENlCA+xYv?=
 =?us-ascii?Q?7qcToQvhTmLQV9rq+qOk4kia1KKEavDAfdxmbEw4EZXgKOtC+ElF+XKHE0EU?=
 =?us-ascii?Q?M5FrkTZefD87+V2ejf2FR00mckhETnKBAdOTem09L/qFGypGH2bOftZghQJB?=
 =?us-ascii?Q?MTJNw/klgRwR2gYKKIB4587h8blhSB29ybOGxYXjVq6deULdT+2/O4cSjNkz?=
 =?us-ascii?Q?ggTSfB1IirgzM54wtxyOgY4mvPPIEgFWvbkimSiboTXm1pANgka7srOP4Gps?=
 =?us-ascii?Q?+lsSNy4HY8lIwY1rCZVz4jULy3eKWOh/sxA7A3o1KbW+VP8Obwtm7sTjnduj?=
 =?us-ascii?Q?4pAZqJjraf9XK5te1zIYxb9jcrFhsvfTdRLopZUVTrz3q545E0Wd9NurhnyP?=
 =?us-ascii?Q?kiiKJ7luYz3rWhLc4LpTMHhldT+zDVW8WXi4H73jjpuylOSdIvYeKcoPqRPd?=
 =?us-ascii?Q?9gOzVTGB5WEI3INCqRApu+rA/vWCq2FnWjPvJaNNXieLyQQmwieCS8uY5oaP?=
 =?us-ascii?Q?AnNi9tXhn6/veNZA2hIHpmIL6fyEK/+CheRCd+FegDve19yRrXoJyXDT9fAw?=
 =?us-ascii?Q?KV/uiGlJwKJd1kDyW+AXvGoTvbBdnz7wD86Pg3XoWuTrloP+er52+QFLTj2C?=
 =?us-ascii?Q?ik+cJhqeTtlQYsesoTZioSEMslFL79JkvOrC6t0hxwv/WkUHTwm2v+q+nmG2?=
 =?us-ascii?Q?J/JAZ3/C4GoiRvnIgRckEpITy+JbOgXONFB/USKyhP83OnUUVzctZmV+BeQ4?=
 =?us-ascii?Q?n9k6NVqmL+xp8g8FdirIvEYDQs08OHU3eRys9Rnr7+FTU5cddt6hU9xoYPFu?=
 =?us-ascii?Q?3lET50uoUpDwmDdMHj/ZCoONSG5758HuwzlqOSfj3UDhoDywKk+NMfEJ63K5?=
 =?us-ascii?Q?TxK50QtsX4EMu9hIQX78C4qTi8Wfmnnm+5dVDm5iIhlUeEwi1HvFbAnON4Om?=
 =?us-ascii?Q?T5vPcvnffCWkZUYJx4fnUQ/4CjGSIgt468txxvilhV0eNJ/sZ3Enm8O5Mcgv?=
 =?us-ascii?Q?XSgyyZ/ID+IbUI5TpJoL54jzswcpYnay7Z5Jlmy1K5Ycy+j2jzViEw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020cdfed-3b95-43db-ab20-08da06516950
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 06:59:55.8170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/9EI4DF3R0k/rJ9fSVnOqpXu3KWLQg9gYjcemYVN38V1CwAA3pOwy4+nvoSZZ4PSklpn8qZDdz9QZKF1Sh/Xe2eyVQhPGX/2PTnV1AwhAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4149
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150045
X-Proofpoint-ORIG-GUID: BwjJLdgh8BBoEOpZQT52M9OeMzYuxalA
X-Proofpoint-GUID: BwjJLdgh8BBoEOpZQT52M9OeMzYuxalA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ep->ob_region_map bitmap is a long and it has BITS_PER_LONG bits.

Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 5fb9ce6e536e..d1a200b93b2b 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -264,8 +264,7 @@ static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct rockchip_pcie *pcie = &ep->rockchip;
 	u32 r;
 
-	r = find_first_zero_bit(&ep->ob_region_map,
-				sizeof(ep->ob_region_map) * BITS_PER_LONG);
+	r = find_first_zero_bit(&ep->ob_region_map, BITS_PER_LONG);
 	/*
 	 * Region 0 is reserved for configuration space and shouldn't
 	 * be used elsewhere per TRM, so leave it out.
-- 
2.20.1

