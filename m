Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9439458FADE
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 12:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiHKKsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 06:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiHKKsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 06:48:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2701923D6
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 03:48:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B95qHn032444;
        Thu, 11 Aug 2022 10:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=1NpaIK/wffzFGXkDJ4yjTa9K7MjS8oz/bBVuw9DpxaA=;
 b=b9FtFWyX5uzYDQKaX9jdqZAmcTFRnqK2nher04dxd/ZYHULmYfiNL4bFJ+AvRPjqJ5Q2
 JLCwdbhg2W9jfynmkm1J5AkdzPuBE5+je3DH5umY1CjdcVgweOM8fYa1jMg+faII65MJ
 RXhanoCxuRZe35buLJZOyC+AC8AT71R3K/OC7pmbM6KaUUxW55qvpsQRHcE+4kuP5n+l
 nlTjSvHy1zAZK69LxuBw9dI+mfE3hfGgx4Rozgw9+4DY6QIrerNxv2oNDjRuHD9WbOMK
 CTg93eCADHryuGTR5K5s1UvYLHPNLcnHevQ7ZwPecqXWNurVb7c4tQ6aV9n4XOkZCnkk 1g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqdvdfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 10:48:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27B9AtGa005040;
        Thu, 11 Aug 2022 10:48:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqjh1ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 10:48:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ua+p/LhU7oqQeqMGb8fQ5OktWK1QXXkS7n5JVJfjYE/Q4b8BfMO7J1r7c44NJm2Aon6plWL4fE+OMl49YupVVSgbsn66DGNIjqZAdkMYwVTM2J7VXBsolwAndbGugmqp4OoXpK3qTPrWwZdgi9gw12vjX+a0C/2mdgl0P34umt0+lT7FDBS2FMI29l5OHvzw9c1D4AntqxOnMch7t+jKKdk+8ptOx7LgxSA2NvYTQf+OF82EnBnQArLjRkFrLYJxRFQFEyhKvKNgxSaTG/XLSGIsV6p9um7tgvedhWYlCXDPuilcpsLfWrmqaX2QGKcuwmT+/xzaz/38TUvYFoteQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NpaIK/wffzFGXkDJ4yjTa9K7MjS8oz/bBVuw9DpxaA=;
 b=oghrl65YRgQWxzMw119rTQGW4MOlDQ4B6bx16pyQ+jCinVuQxtui7/Zz5w9O48j+28L66ml4ca2TlPoBf3PUc+pCH9w0oGoEb4Zy9IWWnBDEMHDmMpti7fP1jUbyORVeVLyl5XdtZiOgQCCBuPpIrzrhffw0gLXVtON8SV8b+qTK76xrnJlBj8KGpdpP/JqEcmWJ8UgJHHMFiaXeDL9ZLZGSBhyKFhWv19sxWpU8qM0jb7sMZQgU2FtVQXC6LNlC7esTUoKDoyDrvLF8Gbb1baetSdqVPsgBJc2J8nTEDVHcBpxC+4yvTWezywDTxi4B3bwO0yYLfLLw7zIXVr4kVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NpaIK/wffzFGXkDJ4yjTa9K7MjS8oz/bBVuw9DpxaA=;
 b=copxAG475aDAHY7VH6xM/Y89IafOJvSGQ8O6rmsIh5GwNX7AX7+/U69y/urIT7DVcdEYHrbW4Qpk0dL+Q6ZrI3cwxgJI0R7+Z/D33e2JU83M5AobfIaW9IpbLCIDZkvZaT2C37L+ZUxlT0Sl6XvDv+zfN/0lKClUSXnVmdFgtTo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY5PR10MB6012.namprd10.prod.outlook.com
 (2603:10b6:930:27::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 11 Aug
 2022 10:48:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.024; Thu, 11 Aug 2022
 10:48:03 +0000
Date:   Thu, 11 Aug 2022 13:47:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Frank.Li@nxp.com
Cc:     linux-pci@vger.kernel.org
Subject: [bug report] PCI: endpoint: Support NTB transfer between RC and EP
Message-ID: <YvTeWal8mQg56xMA@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7bba697-06c4-4a95-0bfe-08da7b86f745
X-MS-TrafficTypeDiagnostic: CY5PR10MB6012:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ep/2dHiV7icPFjMm6e7xSO8ac1PZmAouGQo+6SOl5m1rYP3SdmH/GXSd5Hk+5gMiLWcmmQYRkUi19jkCcXUsde2DjiTI+BY2rqD6OIfEwNuWnmt6kc7H3l1NoXnTzbQy5d34NqHU7l4hmXIlmZLXRtJnGVqv/vPUBz2h5TZr1XYPKFtqSHtes214rY/KnZBJ01u/SofZnwMvt4p3ZUGFqoUtZZpGhqdRZxr9dL2E0HPbPD17fyxClSKKbk90g9XNyIR8yTm0dO68DTnQ/IdDitRydPPAIU578mVCW92DhmwMryfjaunIWJVOZv8dfmQdwJOjJGwHMh5bqEyRG3NUf8/Kk8JjQgx6c9iV6nMaJiq6BYyYOHNt55++aPvtSze7WXHYkBgrWhKSzTxJ4w3oOw17256BxW+c1TpC3eDQHgXr3RogSW2LdNMRUnEQMLqPXQD2kNroWVh3w2uD8RlCGEjI67b7AFz5ZGqjArusVBx3rmrzODa/ui6EUq49RGHubaTByvkP+8ENWSGucHTMSC1nV9U/QDu2UBpIXV1iVHVTFeM+nEgBK3IaCBxB65aZrbk5WvXMTNYyrtxp59fPTNi7IGsmokOF3mnUHmr6DYvuVxzWPGa6HXBYdnO2rgQJaqjohIc/ALy5WLB1hEKCqbqHH8/FD9HBoueqCPBauE1ya789s8Yfazm6ZFJiNm292F7MyutHpLaTDdktGKGQUpbiYojJVQ+/3NY/GQ9GWIMRyGU8IswYBSWcTERqUt3GHzOLUi7T7s7lb4fOEGoEFIU3/bX4VrLeTSa31VmXzGJdYBywxuUWWajKp4/rI1fW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(376002)(366004)(136003)(346002)(8936002)(6916009)(316002)(6486002)(83380400001)(478600001)(86362001)(5660300002)(38100700002)(6666004)(52116002)(186003)(6512007)(26005)(2906002)(33716001)(6506007)(41300700001)(4326008)(66556008)(66476007)(66946007)(8676002)(44832011)(9686003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SF3No9AYnSThDMaGjDluMXNCNgT86TqIHB6MpD11F+tKitAG7S4aTpVqezP8?=
 =?us-ascii?Q?JnoBfDBDEhgb5SKe9SrL5hVJIVg4dRtksAPuPjTO1kVeeIkXIB0T+KJHWkpe?=
 =?us-ascii?Q?xxEcQT+qgPRqKzHdVxe0iHwVaXE5pQ3Qd5k4t5cMtLLeYl0Fdxo5cGS4yAhP?=
 =?us-ascii?Q?wrK6EeMgf+O/byyFTM5IFWkyDuaEQrVCemWUkMsg8WOqchtN/9qjwSICWZcN?=
 =?us-ascii?Q?wXz8d8jFAIw+j29F5TdMLRYObOEq2L0vOaoc2ZPRa2AIivmWRLVPmbJgK8UT?=
 =?us-ascii?Q?MjgHCITZEzAUugZv4MF3WNesHZyZPCWVoDsYCWfGmhEwLWgAxKmZK9HhGXZh?=
 =?us-ascii?Q?GKE+Tz/+XVpe7paMzi6ancMLECTvDEDNCGt21I95mvYpc6MOroiLTXbCde1+?=
 =?us-ascii?Q?8nFbpg5MK26EkXgldLmxWAkVc2qxL6AsCjjl102QILBxHTopHs1Tx3N6/kHX?=
 =?us-ascii?Q?26ppK7aZ7oncpeZObWoa8VExAqf+o2l6wccSnIbWNaSFVk5T/ECNJQDZxMSv?=
 =?us-ascii?Q?gKCfxhIhO6OqNxFQmRANXeEFEoWyxPzYnc8X4lZdKpyRjlvK90VIXixOOKPo?=
 =?us-ascii?Q?fYRavdC5HA0Lk9uLdHU7d53yF4a0J3jQ5ymLh7dmbdKrQHO+n98zAKjT+KFx?=
 =?us-ascii?Q?tp/uY3Dg3PqB6hqsSTQfMvsnces0+MrPuFwM3lxd7QBdttpL1ma4mF/qyR0Z?=
 =?us-ascii?Q?S9v/sGyf9QNedBXwZTfBe7jabjydKTby77wx7ROZLzkflJI5Tgq4Ilu/Bpx7?=
 =?us-ascii?Q?r/tFMTQUo9fDsYF+NJZ9WA1Rbeykkfsnyh25pBVHXVq/CpaFMePYp8ahvMxf?=
 =?us-ascii?Q?WJc7tAKzrcri09wP1AFrVtSNRdWzMNR4gN8JwlwIVBbpdZebvMcoAdifwbVq?=
 =?us-ascii?Q?7KBJyhCAobYQTRpIqMqNglnriNHHj7+18UiPF38/CPybQVGEhRMsu7rbDb+S?=
 =?us-ascii?Q?HaLlYg/ulfPfQBoVoWjxsuKAfr4ACGZ8ba3JBlev9KN/ZkMQGG3pkqNXyL/d?=
 =?us-ascii?Q?xqIoGmilAGU0LWGDo+ud+fLuzqOoNRvl9aAP/ni+mi+qMMLBvIi95TrYJ5Xn?=
 =?us-ascii?Q?PBBenfvMxtYhTn/XXnfdKUOPD8v+gORaUEm/egrXkP4wV4r7iQ+pA5LnAgXk?=
 =?us-ascii?Q?yJHljZti5pAr/zNLTLD9thnw1diz6MvVyoRAOBJdkG2+JhBp4FDesIaZVopQ?=
 =?us-ascii?Q?h3LkQD/npel+zMxM4yWt4OsbLImJk/1IiQp0d4VKmaycuJW8uL2gicZY908E?=
 =?us-ascii?Q?IpWsRR/OWI7uvpK1BmpB3pG95/AF3OCSItU3YeRW3ELEBCbTbqr90KA1Jxg1?=
 =?us-ascii?Q?mtPxLlJ96W5Fm61AxpbhtIqv5T9k/ho65kpKM1QfH+0B0cTIOdqrlcO72yu+?=
 =?us-ascii?Q?5BLohoCyoSsTEgfz+GjP1MEpAHhmt5iAY5sts2ZxVkBzFBORO8LjNkN3gPM0?=
 =?us-ascii?Q?pr+fLhJ3RSDeRkg/a/EZxy/h0dYu08z4hNPhfwv2YffjYKLtANOJf7nJjYtU?=
 =?us-ascii?Q?VChJ0WRYE92Dhb9fuJoghuUVtW+69HtKxz6OKIJXOblJnXvxSiHekQLtZ3f9?=
 =?us-ascii?Q?dZUOuf+ldC46bxkNgAS6rnGpFo8bVhMvak+oySyNXRA3yLHf2Jwl3k5SqYyz?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bba697-06c4-4a95-0bfe-08da7b86f745
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 10:48:03.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QSbr/G01ZUqbgI3NGhsocW2qDjI89TDp4a8d4YL0dLzv3i3sSCEIaEi9ui6glEUDIM/QVZRHgVcUs/yr4UhASjM8wpLNYWr9du75zeYvrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110031
X-Proofpoint-GUID: WQzPzTakekH7FkpRr1dcJG1WPpyfbkJ4
X-Proofpoint-ORIG-GUID: WQzPzTakekH7FkpRr1dcJG1WPpyfbkJ4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Frank Li,

The patch e35f56bb0330: "PCI: endpoint: Support NTB transfer between
RC and EP" from Feb 22, 2022, leads to the following Smatch static
checker warning:

	drivers/pci/endpoint/functions/pci-epf-vntb.c:560 epf_ntb_db_bar_init()
	error: uninitialized symbol 'align'.

drivers/pci/endpoint/functions/pci-epf-vntb.c
    539 static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
    540 {
    541         const struct pci_epc_features *epc_features;
    542         u32 align;
                    ^^^^^
    543         struct device *dev = &ntb->epf->dev;
    544         int ret;
    545         struct pci_epf_bar *epf_bar;
    546         void __iomem *mw_addr = NULL;
    547         enum pci_barno barno;
    548         size_t size;
    549 
    550         epc_features = pci_epc_get_features(ntb->epf->epc,
    551                                             ntb->epf->func_no,
    552                                             ntb->epf->vfunc_no);
    553 
    554         size = epf_ntb_db_size(ntb);
    555 
    556         barno = ntb->epf_ntb_bar[BAR_DB];
    557         epf_bar = &ntb->epf->bar[barno];
    558 
    559         if (!ntb->epf_db_phy) {
--> 560                 mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
                                                                             ^^^^^
Never initialized.

    561                 if (!mw_addr) {
    562                         dev_err(dev, "Failed to allocate OB address\n");
    563                         return -ENOMEM;
    564                 }
    565         } else {
    566                 epf_bar->phys_addr = ntb->epf_db_phy;
    567                 epf_bar->barno = barno;
    568                 epf_bar->size = size;
    569         }
    570 
    571         ntb->epf_db = mw_addr;
    572 
    573         ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no, epf_bar);
    574         if (ret) {
    575                 dev_err(dev, "Doorbell BAR set failed\n");
    576                         goto err_alloc_peer_mem;
    577         }
    578         return ret;
    579 
    580 err_alloc_peer_mem:
    581         pci_epc_mem_free_addr(ntb->epf->epc, epf_bar->phys_addr, mw_addr, epf_bar->size);
    582         return -1;
    583 }

regards,
dan carpenter
