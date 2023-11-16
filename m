Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2772B7ED8BE
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 01:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjKPA5Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 19:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPA5P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 19:57:15 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12hn2218.outbound.protection.outlook.com [52.100.166.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090F9125;
        Wed, 15 Nov 2023 16:57:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4MQrAPNyJGqmKby5SLo7tiFQFS0D2nvm97h65ggBM9vCIUo+rxB5oFgiInCnaYQBFzeU+ryFEOWo0BpHpJuh/iSw5swmh+MqHEyB15xHB2QOf2X9mZCjkgbF433D6LTzfh1ebaLQCndXeo23+F4DjnyDG3d1zBZNFDZBep3bGRfK+weMWxkCT26+ZzAEvthdirPl0QU+ZoP6J30n+QcYD45fYqYIen6sTjXcAlrTTrTTPP7vyA8uIdCdlt5vUf0XKGQ0pe/mh7V3cYDEEQlWTmO8PVKMyuH/pj26/KjHDomZr4O5O1EnFhPmVYGOEhcQQ7Vt4Hli+w5LB+VMs5k7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inSxnn1CyKo0i3KQG8xlXEgitv9f3KLDD7C1MR6JweI=;
 b=et6QIbss61A7AfJKEe4r7/bTpM3s2v8q6ZHB42rICCJz1C2FvQ+N24Lq4RZJlMhsyGSOiWW4kIDd/dNHL868koSnngDYy/oGUnkYSHVsr32pgLc+dIHvS/50qcrt/7MIUOHKNLis2YQ79LyByuuVVK2kibAwv52qh3Ia0WU62DNoCz1u6pyZUFAjYwbz4ZqxNnVwiZNdTt2UknlJ+shgFjFMw/1G+PWCwHgdlhU0KkKnatjIYISEpu7NEowEmznMFKAjYooSfWxIE93RwVhkCYTFzQgKGtxR2kpeUzolIgHJxri2yGxX+ctWMLr1c0h2qiXIQG8jUStM8PEioNXtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inSxnn1CyKo0i3KQG8xlXEgitv9f3KLDD7C1MR6JweI=;
 b=Nd6avZYWk6jN0FcqEr0hBHhSYkwFegPH12FEyRRIFRkRITG/BmPEraJJh7jfJxNs8+Nz4iQYFgc6NwqwANpuH5/JfQ+8GSK14PD8ruX3PnkLnPZCg4F51QMFM+qX9sFtLUFlRAC3Fdpvd2ZFSzsBpFBplEQUAcNmMExDrbTZ+50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CH3PR01MB8340.prod.exchangelabs.com (2603:10b6:610:177::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.17; Thu, 16 Nov 2023 00:57:06 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.6977.018; Thu, 16 Nov 2023
 00:57:06 +0000
Date:   Wed, 15 Nov 2023 16:57:00 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
cc:     kaishen@linux.alibaba.com, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, chengyou@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v10 0/5] drivers/perf: add Synopsys DesignWare PCIe PMU
 driver support
In-Reply-To: <20231104133216.42056-1-xueshuai@linux.alibaba.com>
Message-ID: <51c926a0-b4d7-aacf-12ce-30fad7c5cb@os.amperecomputing.com>
References: <20231104133216.42056-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR03CA0372.namprd03.prod.outlook.com
 (2603:10b6:610:119::10) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CH3PR01MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 38392b4c-c638-4526-d550-08dbe63ef405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wmRKbdNqtHwbYlukc0FmSSJGy7/K5IX7jc3I3xRU48ovt0RpyZxOPsLs6P/f?=
 =?us-ascii?Q?6Ez7+cRx/mIWxYjflQcrq0t070gKPYZJ9efhy+5tWX6b+D82pB4qYwuCbkk4?=
 =?us-ascii?Q?jBJC1/thl86LuER9tJK2z+//KOewHV812U9AYIK+xBLtuoBhuw+wXUGFk3N6?=
 =?us-ascii?Q?druPg8F4igQ7RufWKoJI7KcQOGorK1BAh+XZ+xmL0dWsBqFDV4WIKWbHJz3N?=
 =?us-ascii?Q?Be9cX2a45fy0BQVgwod58SCbwnjC1qQLd3AKs5j6dqcAqlUUhVun9LVVlh6H?=
 =?us-ascii?Q?QQ371R+WderUNWTdiDazNbY7Qr1pBh8sYhoPzRMx9wVNt7M2YPiM27g2Gghk?=
 =?us-ascii?Q?GCXQDorlFXvQgpIlPDV3MKafUBprgWYY7LnHztuSDPxXCD9ThUeed8DiMjqm?=
 =?us-ascii?Q?So0ri5761c3wj3XwsQ/v3yCrb3S88xbD3uf4adbISHEZfQDu2e8Vcir+UYxD?=
 =?us-ascii?Q?VTXIblLxLAn0hMHXUzJC6SYC+p6kJxKGcblgt3LNJeodWq5W7+kB3SMPsMnP?=
 =?us-ascii?Q?D2ILVw/OROclpFOaCWOCffvTpttSQ2pbu2fdguNz0eTFaoW277jrKJV3kT0C?=
 =?us-ascii?Q?b2jupGXyf4G8M0AN80aTS/EAt4DSP1ZZg3y+ZeJw36RhgBwbLXJNYV0QJ3VE?=
 =?us-ascii?Q?BU3phfn1K3NHTrKKc5SCmIxNeCVspf+e2VljIS4OH73PlszCDr0DzIqNWtGZ?=
 =?us-ascii?Q?bUtV3vsjqnk2RDOhp1o/WcIbLgTC/kpVWPqbm2aI3jOzQMJ80LQnEFydAivv?=
 =?us-ascii?Q?D41W33yX3WWB47cps0wKNMLb7rEQvViZ8Sa0K2bR7nZjBBQMPlGl4kwd48rn?=
 =?us-ascii?Q?10mr6V/a5OVDxIKHYGBGZJYm/dteUpyVYa4URcgfLBbAVJSTQ62d7grXrBQW?=
 =?us-ascii?Q?7AgNwQNK5Sg9GXbQq7QWAv2Y0lL+kbyLOC9P65PmVF/vQ1EzFtWTcnB+8+jl?=
 =?us-ascii?Q?wmpR5vK4Ov7YeZHUYfjqKiQMh6ZgNH0R00GLphgr0mylLuzOxwuWyWC79Ulo?=
 =?us-ascii?Q?tsfB0PEYvYmLaxlQ8JnTE8NOZg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:OSPM;SFS:(13230031)(366004)(376002)(136003)(39850400004)(396003)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(38350700005)(8676002)(26005)(8936002)(2906002)(52116002)(6512007)(4326008)(6506007)(6666004)(83380400001)(38100700002)(41300700001)(7416002)(2616005)(5660300002)(6486002)(966005)(86362001)(316002)(66556008)(66476007)(66946007)(478600001)(6916009)(58440200007);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YfewqVtsqgOw5mBOXX6f84SXSJ3cuT0EdQn3qhi6YroHi2JHou4Lkp8vKp3/?=
 =?us-ascii?Q?9+GtanrB6GMQbkLPlTiQvEIj/h0lZSrwEmsIzjVYY2wR00GHF1N/qV6aXj56?=
 =?us-ascii?Q?keWTDS7/Tap0tf/ieRVf/OuOyOCt01GAQIJvKG7U+F5OBiTltG/MoR1WMen/?=
 =?us-ascii?Q?rV0NpRtjBm0lwYSxOqlswb+PFi6U4+N5O/3/dpaIdW2SEnwYKZqvNTJY5ohZ?=
 =?us-ascii?Q?03TTT4/gzsmNhtTdHsMvtuEsE5y7HSofmgDxlLvDogpKwJ7mCX/yOaGa1/R7?=
 =?us-ascii?Q?CrESfuAtV+H74XCIY2ela+lnLRfHu3RBikWPcpap8B6Xv1cXvTQrv5gKMyIj?=
 =?us-ascii?Q?WTevsxSKjGk2VK5HCr5A6Iw3tbcY787DRvW18J+yDSoGVuOvqQYO7K0eWduR?=
 =?us-ascii?Q?iY+BudYQskREIInr+6ud4DoqkGIU8dww/N92kvEsLYuTXXugs4YzyL3Q3trR?=
 =?us-ascii?Q?l34iY22KtnDcMjE5fkqtCWfkTB2tSRYVq7Fs4/Gc2nG9LC0BjPBZqLBeQnql?=
 =?us-ascii?Q?FYzJ/CAFUut73xWYorioglUOQbodHO6uREKmuklNO/9+bIX5BRj8DuMTqz+G?=
 =?us-ascii?Q?QSumo7l4hzOLshjm/yi5XwrW9BHi3K6prM0ZFdB/ttPDUu/2TRFQVSjwjZT/?=
 =?us-ascii?Q?S96r3ssJu1FpejgJ/DxWjW4yBK9Or+Axq6WY6mu/RItc1+XlmQlVmaEnpExX?=
 =?us-ascii?Q?TNBOr3Mk4LUTuCi8D6YNL2sMsl6bU+yoXt6yW2mEOIiDTXEsl0d9/2UBaOu0?=
 =?us-ascii?Q?EwyihM1iSJlnzowi5mOuh75gGjqmaLsLxKUesO0JssFuOqRTokuhE0X5+Tai?=
 =?us-ascii?Q?a4g2W8GMLVS9sYPx+VovTmlGV7x4Y0gQrKfZwTbRg64gw68rAA46K6mDHJAo?=
 =?us-ascii?Q?HRhBGzv55SDNxgFJcp23MLpNWwstnK/uS9aOEEz9SdIZaxVOBe561rw4cSZT?=
 =?us-ascii?Q?Ylgn0A7ej3mQHnEpDh1xKCVN9Qm1ma9gy7BVHi9vn8WX27VHX/IWjQxa4FM/?=
 =?us-ascii?Q?zGX0AGEfF3St9zt8sbpGuSvJyno6G20zRGWZANVcIHA83ysYgtMMuTAbe+YJ?=
 =?us-ascii?Q?7mrVzEXYG1SAQGpeHzmYu26rg//wWrjm3NjQ4SRHrPtL7681XIUPD1vdQTsh?=
 =?us-ascii?Q?2qaJiPR/GFQkZBRv5nJzSfLrAnAs0uolB0l2BRcGpfYa1oZuCFAIsFQoF6b/?=
 =?us-ascii?Q?eUnFbCJGPadEnwvgBJL8/1sQn5R/VKwjfhLWI/VNmPlVrYt0adWAf2uONYNk?=
 =?us-ascii?Q?SMAxGyHsx4RC8bQSXXSMXdi7yEq60gVnvaK2CqL/XjU3SMibuDMm0UPlMM2T?=
 =?us-ascii?Q?RhopQEeC8j7VLmAad21w4Kxw8vXB+dl7WiOLg4O/t8r/TG/4TJI0nRt/Y5Fc?=
 =?us-ascii?Q?TTN3XwZCY0kVhHXgrNYj/lVz95EE1T+CyIiyIqcsqAV6JfTIAA6rOuqJARpX?=
 =?us-ascii?Q?jmkqYO7tRaq5T57gc4N9NLaxSoDnqWdS7zDsJcFlvPSlFlC6jT/Ah+Nq+uXU?=
 =?us-ascii?Q?6ZiMFZvQJZN8VZ1JnTny8dZDuJ/5V1UZQICecnXL1da2hlTaxlpP0hDBQ+ww?=
 =?us-ascii?Q?Rw5nUjYTBo3AXEafqwUSF1Ufea+bQk4asfovZsTGQQXcQcXJABCyLVvKHY/o?=
 =?us-ascii?Q?K3DYuHjDVdJ7JDh6I88rk9c=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38392b4c-c638-4526-d550-08dbe63ef405
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 00:57:06.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHK4kIUdaHl8qExi6KTeItW9j2ui6MGGpTJ+tnFQHY++bQGS7DlK020V7lF205g1OSuiSytMMXArfqN/ou8Sm18OgFt0Iurhc/OlQH8MiVcm8EePUuCIhUbzu+RUCNlN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8340
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Shuai,

On Sat, 4 Nov 2023, Shuai Xue wrote:
> Change Log
> ==========
>
> - move the &plat_dev->dev to previous line to warp more beautiful (Per Jonathan)
> - rename error label with the same suffix 'err'  (Per Jonathan)
> - drop unnecessary else branch and return directly (Per Baolin)
> - warp out set prev_count from dwc_pcie_pmu_set_period (Per Baolin)
> - use PMU_FORMAT_ATTR to simplify format sysfs stuff (Per Will)
> - export pci_clear_and_set_dword() to simplify _enable() functions  (Per Will)
> - simplify _read() function by unconditionally calculate with unit in bytes plused if branch for group#1 event (Per Will and Robin)
> - simplify _update() function by unconditionally mask with 64-bit width plused if branch for lane event (Per Will)
> - add type sanity check in _init() (Per Will)
> - test with fuzzing tool before this new version (Per Will)
> - register a platform device for each PCI device to probe RAS_DES PMU cap (Per Robin)
> - add dwc_pcie_vendor_ids to extend vendor id for future added device (Per Krishna)
> - pickup review-by tag from Baolin, Yicong and Jonathan

...

> Shuai Xue (5):
>  docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
>  PCI: Add Alibaba Vendor ID to linux/pci_ids.h
>  PCI: move pci_clear_and_set_dword helper to pci header
>  drivers/perf: add DesignWare PCIe PMU driver
>  MAINTAINERS: add maintainers for DesignWare PCIe PMU driver

As I mentioned earlier, I successfully tested your patchset with a few 
patches on top of it to enable DWC PCIe PMU on AmpereOne. Thus, feel free 
to add this tag to all the patches above:

 	Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Br, Ilkka


>
> .../admin-guide/perf/dwc_pcie_pmu.rst         |  94 +++
> Documentation/admin-guide/perf/index.rst      |   1 +
> MAINTAINERS                                   |   7 +
> drivers/infiniband/hw/erdma/erdma_hw.h        |   2 -
> drivers/pci/access.c                          |  12 +
> drivers/pci/pcie/aspm.c                       |  11 -
> drivers/perf/Kconfig                          |   7 +
> drivers/perf/Makefile                         |   1 +
> drivers/perf/dwc_pcie_pmu.c                   | 798 ++++++++++++++++++
> include/linux/pci.h                           |   2 +
> include/linux/pci_ids.h                       |   2 +
> 11 files changed, 924 insertions(+), 13 deletions(-)
> create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> create mode 100644 drivers/perf/dwc_pcie_pmu.c
>
> -- 
> 2.39.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
