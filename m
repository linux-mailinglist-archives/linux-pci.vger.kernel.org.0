Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F1E5286E7
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 16:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244614AbiEPOXi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 16 May 2022 10:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244565AbiEPOXc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 10:23:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEA23B2AC;
        Mon, 16 May 2022 07:23:22 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L21cN4Q2Zz67NY6;
        Mon, 16 May 2022 22:20:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 16:23:20 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 15:23:18 +0100
Date:   Mon, 16 May 2022 15:23:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
CC:     <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <acme@kernel.org>, <john.garry@huawei.com>,
        <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mark.rutland@arm.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v8 6/8] perf tool: Add support for parsing HiSilicon
 PCIe Trace packet
Message-ID: <20220516152317.000029d8@Huawei.com>
In-Reply-To: <20220516125223.32012-7-yangyicong@hisilicon.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
        <20220516125223.32012-7-yangyicong@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 16 May 2022 20:52:21 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> From: Qi Liu <liuqi115@huawei.com>
> 
> Add support for using 'perf report --dump-raw-trace' to parse PTT packet.
> 
> Example usage:
> 
> Output will contain raw PTT data and its textual representation, such
> as:
> 
> 0 0 0x5810 [0x30]: PERF_RECORD_AUXTRACE size: 0x400000  offset: 0
> ref: 0xa5d50c725  idx: 0  tid: -1  cpu: 0
> .
> . ... HISI PTT data: size 4194304 bytes
> .  00000000: 00 00 00 00                                 Prefix
> .  00000004: 08 20 00 60                                 Header DW0
> .  00000008: ff 02 00 01                                 Header DW1
> .  0000000c: 20 08 00 00                                 Header DW2
> .  00000010: 10 e7 44 ab                                 Header DW3
> .  00000014: 2a a8 1e 01                                 Time
> .  00000020: 00 00 00 00                                 Prefix
> .  00000024: 01 00 00 60                                 Header DW0
> .  00000028: 0f 1e 00 01                                 Header DW1
> .  0000002c: 04 00 00 00                                 Header DW2
> .  00000030: 40 00 81 02                                 Header DW3
> .  00000034: ee 02 00 00                                 Time
> ....
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

From point of view of a reviewer who doesn't know this code well, this
all looks sensible.  One trivial comment inline.

Thanks,

Jonathan

> diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> new file mode 100644
> index 000000000000..2afc1a663c2a
> --- /dev/null
> +
> +static void hisi_ptt_free(struct perf_session *session)
> +{
> +	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt,
> +					    auxtrace);
> +
> +	session->auxtrace = NULL;
> +	free(ptt);
> +}
> +
> +static bool hisi_ptt_evsel_is_auxtrace(struct perf_session *session,
> +				       struct evsel *evsel)
> +{
> +	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt, auxtrace);

Check for consistent wrapping of lines like this. This doesn't match the one just above.



