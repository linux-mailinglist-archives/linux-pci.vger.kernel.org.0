Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B15B747AD7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 03:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjGEBHX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 21:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGEBHW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 21:07:22 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1382410DD;
        Tue,  4 Jul 2023 18:07:21 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3650wxGj031374;
        Tue, 4 Jul 2023 18:06:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=xk+8FAc+71HgGU7A91
        Fz8DN9eMKR/Hm7Pj0V2u9xSDA=; b=qpkeLLfGZuyZHyA06UK1wVxc9ypWU98xkL
        RME/xzuYkX5LPFjG8o9Rbid4xxxzxhIXvIQ6zHz7xPclZ6Xb5oNlBGKVK/znJvJE
        VW+E7xT1Hus6+Cbjru42xy9CADibb7wAqLC5esndw2aPWTacyrnLsFbx+XVNVrp8
        3rEoWDA4lamgzdtZJzAhR4oVAtwcEARyvnG0rHZKtpvCRR5ni/NlTwnWdheMaw+j
        l36PBzI0k32jo5W9s5jV849vohI88xUpACKvUO2j2TavD9v6T/Qufk8GqmXfaG6j
        WNSaVGKanbnnpfyKl6W62NKGXR6QHqEWnW+VFftPPXZXtj6dUdcg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rjfdytnue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 18:06:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR4lUf2rbph88cCdExnc5ckQgV8/ip/6LporQxLXTvZa19HcAT4lUzJEQt5v/sCHSBs5Ks6J4OdMwK54ZG1xX850jbJgrFdoxUh66jMQD0G7jcFBY8yXQi96+p98eDNL3/OL/O0gk60P5rJYCnoW5YEWfuEaYkZVf7N8ZTW1Pffxcap2dw4ynX3hjWmbGf1/TmZTtxpnn1i2f4LCtg8/0DGOlTLY9hRWn1eqAR15aYx9KbiMsCEHcmZsph/Pkuz/1Mo5CuQlk4JF9fOBcJ4UGDJTUIPEA3tTnAOaGpeAZ8iDtbWVZ2jQLwhyCdgYwFWV77qTCjkB8zzIYqzXTnayvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xk+8FAc+71HgGU7A91Fz8DN9eMKR/Hm7Pj0V2u9xSDA=;
 b=C0Np9ccEjn+XjBa2+sUG4oOnhJWayKCA+IANFk38OGK7sFh4y0HlHWciJNs6JQOvbfClopt3D0JWYZ2gsqYAhpKYlzMfz8Kg5xqwDu0i2N84uay04VnsrZ3MiDsIs5WgqQtPVN9uRNhKGcXlu8jkWTENIANcNdoYfFs6C/CgOuzgPNt480oEUmAJMyAtEluqtptC+suFHfuDL8xDD1VPYl0iDCgOARsuL02KgvfCA8IIFvwcP6MaWJDnRtWyoUFnaMIdnYomzPUcjjWCvT9YKSnE60kLmlOSbyLwg480SABDvlvuHR2D/UdLVGDgFkW10327G7TBu8v6FYoe1Py+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SA1PR11MB5780.namprd11.prod.outlook.com (2603:10b6:806:233::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 01:06:49 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7024:8e67:fd05:3242]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7024:8e67:fd05:3242%5]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 01:06:49 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     hongxing.zhu@nxp.com, l.stach@pengutronix.de, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: imx6: Add deinit for imx pci
Date:   Wed,  5 Jul 2023 09:06:24 +0800
Message-Id: <20230705010624.3912934-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::22) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SA1PR11MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 32577df6-9c4a-4b3c-119b-08db7cf41c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++S/NxsuUA5zU+c0bJZVGmwrWazJXXAT46iHJ9VL1nMj+aBME/l58MNVxgHrj8OA6IJzeTce3OdAQTWrs5KZiO3ZS0ce/1qi/xypuVpkOiuX+WPMfuThPDXCUwqqnu8JXHRJ0tqFRlhz8y50dkNZ8xxuMIQdl9oaipzVBdjzo7FDkCYx/iNyH7fvREOdqcz93a1p5eGM9ZLaBqMa+lqnOIFxW4o0dF7NpIEu02skJVF8QYqy+o6MBlnqyUOcGtlcY0GbdBz0f4/EMNkTjXrF6kjG3jNePli3jBObFinIkmdNLsGhxMkVD6dO7a4KebaSEkeV+bRPie4Ft7QVq+MvayRojFfrbkiA37SkdBLRxEwgqOSfRQpU7LyIyDtWrNUCmWnGO9wKyHokmeo1/hvETuex36HvHeWMy5gBTag6D2kTRXwMjraJ7DnxgYdszQtcJ5Js6Bf7IRxJYDcuHVRggPwmoTH9bzxp+qmnM70Os5wn3vzDd4R6eMFe0dIO9KbmSdk3W3tv+5m/YUiGqPePe5sFOt6/8wklPj16pDeWSgig/ihE3im6EU40Hv8LXhc4c9IvGnm4yPpgg2zmjRttQ4B50csghTsbbay+FUUpcRGP1J/1lulJMBrAW2Eietcz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39850400004)(366004)(451199021)(44832011)(7416002)(36756003)(66556008)(66946007)(4326008)(66476007)(2906002)(478600001)(316002)(8676002)(8936002)(5660300002)(41300700001)(86362001)(6486002)(6512007)(52116002)(38350700002)(45080400002)(38100700002)(6666004)(1076003)(6506007)(26005)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bq7moxLEdjuLtD9uDxo9FQ+DZolhJYD1DTZhXcLxz4zvLycvmrkm+n3YFY+G?=
 =?us-ascii?Q?qOhDu8HualmIuSUduCL+GBiGMEgT8sgOeDNXEdufP6xmtItYz+GZROOrp24s?=
 =?us-ascii?Q?80rgSQ9wFq7oyepyiFLsPztjwU3Q6AaEcmCBvWaCxQ5B6bEDzB6aKCLiwrBQ?=
 =?us-ascii?Q?eV9g4+716wxy/dcGKRjrO3EioOVfxyOLXm/zPp5NeWDaOxUbIw+mGNeHWLKA?=
 =?us-ascii?Q?ix6taVlXIgnaVWzVbZXfIZ5/PE9LJCmXLZLmxGKcCVMAU76u8H8uD1L+3t+i?=
 =?us-ascii?Q?mrZ0wEn2Zjp9RAkzUfUNuuJxbnXfr0njld6Zs4DZfLT5F0PJzVULniOsB0gQ?=
 =?us-ascii?Q?Rl/vvwd3Qr8vv3DLUkAgNbVN+mH1m5Y+hoG0VpyRjlkwqtIctFBPUl5pEt7y?=
 =?us-ascii?Q?K1TLhMXJTpxIrFbcQCldxvDb7Csk1sFMnfN8qm71YT7rD0wpd69mN7nkr42k?=
 =?us-ascii?Q?QlsFdb/JPcWiB0ZeO5GfbImS44keElUPPmvWebfgYS9PT7+ttawyWDO6kSkO?=
 =?us-ascii?Q?Iv4sn3R+dRks11oUQm4FfZrreHv2PHAsfvlIvxgIrGcdDVE3VGH7kkepH4KK?=
 =?us-ascii?Q?BTlsBWcGjRNNVTieG/cqQcLY8MOAELwXIDMBJuR1SfiXM05ycTtLByzxRqa5?=
 =?us-ascii?Q?HhwpkX1Dikr7emvlaqaZo+ND2G11jaEQ8Rnq/PdPahYvA562MFdZbjyGhz+l?=
 =?us-ascii?Q?NdfnnvPdcOu3CYm2a9Vqc5yzE74Qi729Wyk7plUQG4RuePqzIUjmnCuoKACn?=
 =?us-ascii?Q?Saray9SDU4z1DLgzHXzslaIsOt/U7BRuC3ZSfOIiTew1pM0RuXCl3K/AEYkV?=
 =?us-ascii?Q?9dj2vtjLGjrqOPWAR4Z5PXl8HuVDRaka8a3bdhwzH4mKQD4/UIHoz5xpQep/?=
 =?us-ascii?Q?B4DHv/ZwZg7WFnbHdtyy2fXewWNG7twPDGdCeaGGRqd7H1PzFWPHSxBBn7Jg?=
 =?us-ascii?Q?L0bS+UvKrI7nTbTpV+hPPVnW06RyT9dGYlVWjmxquX1MasXPV10sL6OShB13?=
 =?us-ascii?Q?GbMJ99C8pqd9S1Xu27cFfHUief6eJZQrInLk24hZgRLzMyZ1pBy+p8SjPHtX?=
 =?us-ascii?Q?XJnYjJSDTcry9dxm0if/CzYcb2woD77p88UkHAtORMG23uSyaQw1BJX5oYIL?=
 =?us-ascii?Q?YHR3TesfgwLQhshTaYwD7ybr8OBNWH5hT1KoPlTTrt+pNsP9O9QAeRTgrUIC?=
 =?us-ascii?Q?ZzKbS/UCsAwyhQ+IgdlHui2LnRegsQSuwpPj87FZ3ZlwalUrGr3BEZbhqrey?=
 =?us-ascii?Q?Tr4KCLn40WocTfBom+VhnS3QDATsA8hWCqzkCx2Detq4EkDgiF6JmkB5d9wG?=
 =?us-ascii?Q?RiUPHtwQIFvXJuhYmPsohwbaeurkX0zfr/9bcc8Ofus5vg7b8mydQRZABLN4?=
 =?us-ascii?Q?0fV3ccD19AQbEVRWZeFm58jpqxmHa+dIt+vumqSl9XNQELQ441Vx0mGozOa7?=
 =?us-ascii?Q?GEIOrAYlu8T8BHjjx4rYSzLup3+OV3+cyfJl1n74p0Ip5bFIJh/VFgbXiam7?=
 =?us-ascii?Q?ilzKkiAIZp8THx5n9F38ntzB39/hPaXBNMUtvXXTaE9KSZBndBGvcoaxMFxF?=
 =?us-ascii?Q?dUvhvq2M/Ea5Bz5R2jccogPDWfAPaSCdLszBeXZaq3cBuM+mH5rW6uqruvrM?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32577df6-9c4a-4b3c-119b-08db7cf41c47
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 01:06:49.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRbl4outD5KlEh6EP68TOHKPn7ypJliZoIOSIWbpWfTZP1isLbhnHx6SLgw7Nkd6i8cc05x1mOGYnVcmiawNwCMw8VAqs2ijpioAdltd07A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5780
X-Proofpoint-GUID: XkiDhXX_HHi8f8wBIlXXs7-o4WAMKa4t
X-Proofpoint-ORIG-GUID: XkiDhXX_HHi8f8wBIlXXs7-o4WAMKa4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 mlxlogscore=881 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2305260000 definitions=main-2307050008
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit da56a1bfbab5("PCI: dwc: Wait for link up only if
link is started") adds the judgment on the return value
of dw_pcie_wait_for_link(). When no pci device is connected
and pci does not appear link up, the link will be stopped at
this time. Run host_deinit, so add host_deinit callback function.

  WARNING: CPU: 2 PID: 70 at drivers/regulator/core.c:2398 _regulator_put.part.0+0x17c/0x194
  Modules linked in:
  CPU: 2 PID: 70 Comm: kworker/u8:4 Not tainted 6.4.0-rc1-00001-gda56a1bfbab5-dirty #22
  Hardware name: NXP i.MX8MQ EVK (DT)
    Call trace:
    _regulator_put.part.0+0x17c/0x194
    regulator_put+0x3c/0x54
    devm_regulator_release+0x14/0x20
    release_nodes+0x8c/0x13c
    devres_release_all+0x8c/0x108
    device_unbind_cleanup+0x18/0x68
    really_probe+0xe4/0x27c
    __driver_probe_device+0x78/0x12c
    driver_probe_device+0x3c/0x118
    __device_attach_driver+0xb8/0xf8
    bus_for_each_drv+0x84/0xe4
    __device_attach_async_helper+0xc0/0xe4
    async_run_entry_fn+0x34/0xe0
    process_one_work+0x290/0x5c4
    worker_thread+0x4c/0x408
    kthread+0x128/0x134
    ret_from_fork+0x10/0x20

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 52906f999f2b..e4942bd2598d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1039,6 +1039,7 @@ static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
+	.host_deinit = imx6_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-- 
2.25.1

