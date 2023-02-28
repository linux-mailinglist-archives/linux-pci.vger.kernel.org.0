Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEF56A5249
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 05:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjB1EWA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 23:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1EV7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 23:21:59 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2116.outbound.protection.outlook.com [40.107.244.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E81426593;
        Mon, 27 Feb 2023 20:21:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3pBlyTOb5bw/BMTomNs6YXpP2wZ8XavqetmTxqOhGsydTepFzfPXqY/OIIutg5xVXOtucHU92LJkfS8h1I3dmSVtoLgZs+5WmIgbK9ZBjmc2LqD6cGhpCC+bnKzi9A+XPejkK25b75hWrIncC2UpRZGywqA++Ul5jMf8gW3/mnL2M8z/CtcNHYqs1PxDzbUzZOypzcqiNfPDnM4ElgyewogZ/yWHP0z8MdITq2a0P+IUo4CiY+gqfqGNH8ehn8iNBzidZjT8XihtVJvspx7SAwfDyETK0t5o+W73tWTgnoAbIaUjjkhN6iCVdcTzAnQQgm+LjvRTrytrc0CjKzroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBBkRKzy+PlDDJvhrSn3NLs8rAhPCSzRoj2g9kieCZc=;
 b=PAS+poi5P4iuS14odCpe+HzXFQcK5jSTo1iDVLO2LOJ8gcFl6SloKdcKRPmC+zXfd8ewuzT6YghhvQcN0g+Ekj4P/PtI1FXRnp7XmxysQkfQwj/idi/KPbLXN5e1ZDlnKPAmh9nSygdA12zGfl/OYKZdulf3VWBtUOuY2JmwsI/yttUR8qkRDf5kB1Hu7gzXoHKRNblGM1ZwBNKroV+0miUpiJ6IsF40746NvVUi704y3x31xqsr8DFTRVLgRKikzyYg6BbvgYGNwb+nzDR1hq3eD7FTVSJkkru61hJXO3PWAepfzdci4fq8aKXwiMzl2hyyP0qxp71XK2qtTCKT/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBBkRKzy+PlDDJvhrSn3NLs8rAhPCSzRoj2g9kieCZc=;
 b=ZQcKhOuwtOneC/n00VoEKHy3/5Isga7PLIp7leXNd44likMYywumNnMAS99PPGvG9Gwn3WR768JLWMhM8Ln8KGRQxygDt/2GpxvKSBnooNJ5g9SXXhdpsmrZFpAViBGVYY//lwAZN7QESubsYCf2woVSscadQ/nQpEF3WqMomMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 DM6PR01MB4700.prod.exchangelabs.com (2603:10b6:5:65::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.25; Tue, 28 Feb 2023 04:21:52 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%6]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 04:21:52 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        gankulkarni@os.amperecomputing.com
Subject: [PATCH v2 0/2] Add support to enable ATS on VFs independently
Date:   Mon, 27 Feb 2023 20:21:35 -0800
Message-Id: <20230228042137.1941024-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:610:75::24) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|DM6PR01MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: e230a59f-f9d7-487c-3c90-08db19435157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Flivy6uyTnreryHlem3s0F2ASsXlBFBaIa6Zw5aF0PYxDB6Fi9FjzxZJZJyHgod3CVgHMDERUdUF7Sy4DdikQEufZ8/8MyXW//qXtJSXndB5LXhZncrG+iXbrP/6ie8YvnZFYkxaCQP95dsN7uuZ+3XncIGjSAoOgBykPogjxq+IhwOiE4IBvFudP16TzjnL2mpl6cI1sGdWWt5kdp9sizlwEbzblPhV19PNAMmS+usPbsYzf7VoCAC7Ehp247fdcuf2UIHJpOHK8OEYWgk0BR/bvpaa20MPj2uCyFDVnR2di6L7CKKSxNDNb+3dJT4KlBf4lp4A2tZloXJlAkAROPGGYz4+Ioy6GFZ8AzoDxClXLulDQzKviQ2lpCRKhR6nwa29hEPV9ACFFz7eF6T8lPopE1YoohuW+g6yUzVPexXzl+0lRDkf9vH/jHaSBvEsceFlU7YdAbzPXQ42IwOyfSvVC+t2yehWZzptv+f8dz5cx6ywGJRo1aretvTa/dX8tHJ/fRM48UCTj9iDnPmLdFqMLg1i+DaI5aaYQGAjiJ0cVsMoM0JhUZ561BakVBCkmMlDEMLQHpJ0BdQs9bVJOcPbNuS4uu/O0ql0QMipn6HpCZ1qKQyjoLUviA87cDQsUdGZ4PwxHdDgyKQEY33kQNq4pBGvov8ow3tYpBvLaqap5ik6g/LxjXK5VMIsqdd5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39850400004)(396003)(376002)(136003)(451199018)(966005)(86362001)(316002)(6486002)(186003)(4744005)(8676002)(7416002)(66946007)(41300700001)(66556008)(6512007)(4326008)(8936002)(478600001)(1076003)(2616005)(6666004)(26005)(5660300002)(107886003)(6506007)(66476007)(52116002)(38350700002)(2906002)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bILgfdYN4pZGJKsfBlwL/uBqUP9YFDRgymHCTxvB4RXhK/sGwdA4KDhchjsc?=
 =?us-ascii?Q?MAthKEVIJXYsPXlEfHhReU6giW1VNUF/7yqATwI+2IIq9a9jZ5fVTqgwdY9p?=
 =?us-ascii?Q?eBTh8E64QGkGsbUY+4hynYiZHeBict0St87I7veTsWEy1GFzIsBPqhLBnpeD?=
 =?us-ascii?Q?e5aOq9niCJOaTN9yUk9NAmFwBC9nRcajSS3lpX03TOXNzcu/tChvYYKh55kq?=
 =?us-ascii?Q?qxyi03xgxA8ECQCKHSNqB3A98Rmu8u3GswjLOhI3jv8lNYUGDY1GCsa1B3q2?=
 =?us-ascii?Q?ZS0yxfUpIhGf1BMo563APIwikfvqVmq6sQnjWFejg5689P/Tn4N5y20WudTc?=
 =?us-ascii?Q?XqhB/oWJyGKVSUJ98UDw4iPE7hbdiye3bx4qni/pzgDMoU9E+9gOPLdikmV0?=
 =?us-ascii?Q?ota+URR57EMZuSU3AicCyTnoDAQtnIIlobC9VPfCLVU8THtAJJFCx0q7Fam+?=
 =?us-ascii?Q?FCOnEW85beNMqHmrvzhGwaaQLSwF+i7XsQ7zCrnzYV78V2yGI8xA/itsETg+?=
 =?us-ascii?Q?nXFPvENHjWdjAdMcqSRTwJcFP4WXq9z+AdpLSeap2Xe3eFhnXELkK+X9hd+L?=
 =?us-ascii?Q?9/r9E52WxUH9h0WmB2g3+S/V4V0cglyRRXdEi8nycSGmXK/AOsJGlWs2mo8r?=
 =?us-ascii?Q?uZKNrp0BSaPdkoHkldshlFFIymX428QtX9xjX9kC9BBIXgfXKvQtg0XumpGp?=
 =?us-ascii?Q?3jsmyWK230nXTCpcFwo/a8sWvOO3otHs5XIZpTDtDz/bfIRX13tCg4PGInLn?=
 =?us-ascii?Q?6I9yo2puznciSJOaf89cPBNBdId0ls/bcWzwsslgywX1wRLAt2nGAPDs6UR4?=
 =?us-ascii?Q?BYWR1PW59nyPHIoWDhpEgeyrEk+Z/fnh94ag3Fpxz9hFmES2/DXRWY1Ekk7N?=
 =?us-ascii?Q?yDL/fwKLSjXmCuhYDB1xEuIdQFlMGzg7NNd/6Ya1Fp/R84maiP9IjW27iMOP?=
 =?us-ascii?Q?RgxCtu/P6baTQLWOgtAGFOD44V28zeFFa+7BeKrH9Lkdz3T3sdP8X5ADSnCc?=
 =?us-ascii?Q?iU4gznQzTEVc3/LQn2GE9LnQmeA7lnO96niuG6aDD6OhD4s6mbwD2xazxYDo?=
 =?us-ascii?Q?eABDXdIvpsjzxAjpC1ew/KY5vmo4QKaTD9XX4ESb0fP3mj/xBDJ54w0iDkty?=
 =?us-ascii?Q?xyLxJHLHeBs8ju5K6uufFnXdNLC44YcwxNvi05dah4BnB5s7dzSGC8YLYemG?=
 =?us-ascii?Q?TNDN/3+XYoc113SiBkVmlJJ+SOwdpc0CLeQJGbwB1kaYlFf3vOkMVwKNVH74?=
 =?us-ascii?Q?3dGFZUN25kdyiaEQAW59g1tbVu8SfhIS46arwyLCrz4MuoGYUNGwAJADc3CJ?=
 =?us-ascii?Q?F96/TP6KLzBd3QH9wYbR0Q2H+CG+zt4nvepoxD3A24Vp0fPqzst/EnU78rAo?=
 =?us-ascii?Q?o2hzb8fv15ZgnIc03v9O5e3jctKdUIICe4ma4XEJcadpDr+MaVK5h/+DMyPA?=
 =?us-ascii?Q?JoC9u/tvU/VIaLgt6zDG28c4uuzC3DEUjqvHnRSj20+MRN2QQdTLXXITTkYZ?=
 =?us-ascii?Q?ZwiVOQrzBxlsL+l8z342apYQDKm9D3vUTHT0Ny4tJKxWn6/urINbgZpUTz3k?=
 =?us-ascii?Q?IQeougO5IVKpQD3i+coX29Z2ey4P9Qe/BSlp0Qx8k28Tj2weLl27Gq1Wyjh+?=
 =?us-ascii?Q?Ngu1rby7IamKUMSVfXY3Q9c=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e230a59f-f9d7-487c-3c90-08db19435157
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 04:21:52.4825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpYfIAlbMtfnJ4BQGJIZBfBTGX3DEViKHUIp9HRjwsT+3do7MEK+y0qgh4S9Tze00dWN6dNSlY0En8xq4WXS2rW2Rl7JcojY+f+p88MRe6JydRH4Pfn9ECcpaJnzO5zC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4700
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As discussed in [1], adding a helper function to configure the STU of an
ATS capability. Function pci_ats_stu_configure() can be called to program
the STU while enumerating the PF, to support scenarios like PF is not
enabled with ATS, whereas VFs can enable it.

In SMMU-V3 driver, calling pci_ats_stu_configure() to confgiure the STU
while enumerating a PF in passthrough mode.

[1] https://lore.kernel.org/linux-arm-kernel/20230221154624.GA3701506@bhelgaas/T/

v2:
	- Added dummy definition for pci_ats_stu_configure.
	- Changed STU configure to read modify write.

Ganapatrao Kulkarni (2):
  PCI/ATS: Add a helper function to configure ATS STU of a PF.
  iommu/arm-smmu-v3: Configure STU of a PF if ATS is not enabled.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 +++++++++++++++-
 drivers/pci/ats.c                           | 33 +++++++++++++++++++--
 include/linux/pci-ats.h                     |  3 ++
 3 files changed, 58 insertions(+), 3 deletions(-)

-- 
2.38.1

