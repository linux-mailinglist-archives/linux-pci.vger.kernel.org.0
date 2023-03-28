Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A66B6CB812
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 09:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjC1HcG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 03:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjC1HcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 03:32:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5710E2681
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 00:32:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y4so45862338edo.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679988720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPsI5cRc/cuesNH3pdp2fw3uWubkgugrY8WXevRwjNA=;
        b=UjKT8cqHKH/KSRzIqYt72GEu1207KY2hDyYfoXl86GnorTQtSMwyP2FeXWzt8gHsN8
         3cltjwwXh3Q2D8cH/5suU0KUdfZqUagGFPo4AlWPoOBYRBMFyL8u1QCNG84YOuYC9mGQ
         iB3aCWIo6nGKbF/M9j1iRkGQ6+RZ6zrD4098ysSfauGYg2RDlu+rFo7dgEZLi/WnfjGS
         Vz9mHO5ubNsE2OYFW3KuvwyPlkVP5dVFAXlqKvO4gLZyX2dAK7MOdAGZ8TtrLuF0xDyp
         xyZyq+ffLYiQvrAG3dnMA/vzSeJ5jVT4aLXEMpN6ppc3yn58xAe/HLJr+M1iunE8giap
         3yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679988720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPsI5cRc/cuesNH3pdp2fw3uWubkgugrY8WXevRwjNA=;
        b=ttctHrFXJrNyim5X1H/xqqRHFH/gntsIm5HigW0M9BVurqzQCthm9zkQwIcDMCfWUJ
         8TCWvzf6teRNTHbysmSDycwJWIDya2t7ljFIFC69+ob5/Zl9mplmpw1BTKu/Y7wrmaTj
         cLSaT7QsGG2A8jjmwxLnByonvfU3bXnwIXluI7SwLUW7uz26KWFsDJg8smnfxydictu+
         32P9JjKGjWeSxDoUbuRGnXcYZirzMUPilQzbuC5zJQg1wGCiErkqRpKUx1iO2CHTCQV4
         r9Bc1TKrOFqMGf0c5HfydL5pu344sQsele+Eh5jXHxn1shdjgUtf3mvMf7tzUTHX/fZJ
         Mztw==
X-Gm-Message-State: AAQBX9ey3QVHc29SUT+J9YuQT0J6QQ0APD0NlVRUTVty/cg4yT9PL9I3
        0fWweS8ewPUqrl5NsXVjGPQ7uQ==
X-Google-Smtp-Source: AKy350Y6jVw5G4dBbe5beWjOBJfOj5lVrspKDgOVbHkcbC0TX/WFJ3Qucjac1D7aDu+YYdj900sV1Q==
X-Received: by 2002:a17:906:d154:b0:930:a3fe:641d with SMTP id br20-20020a170906d15400b00930a3fe641dmr15978010ejb.63.1679988719810;
        Tue, 28 Mar 2023 00:31:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id z13-20020a1709064e0d00b009351565d1f5sm11442664eju.52.2023.03.28.00.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 00:31:59 -0700 (PDT)
Message-ID: <8b04a266-20eb-f1c1-278f-764b1b06b78b@linaro.org>
Date:   Tue, 28 Mar 2023 09:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v4 03/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230327161426.32639-1-sumitg@nvidia.com>
 <20230327161426.32639-4-sumitg@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327161426.32639-4-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27/03/2023 18:14, Sumit Gupta wrote:
> Add Interconnect framework support to dynamically set the DRAM
> bandwidth from different clients. Both the MC and EMC drivers are
> added as ICC providers. The path for any request is:
>  MC-Client[1-n] -> MC -> EMC -> EMEM/DRAM
> 
> MC client's request for bandwidth will go to the MC driver which
> passes the client request info like BPMP Client ID, Client type
> and the Bandwidth to the BPMP-FW. The final DRAM freq to achieve
> the requested bandwidth is set by the BPMP-FW based on the passed
> parameters.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c           |   5 +
>  drivers/memory/tegra/tegra186-emc.c | 125 ++++++++++++++++++++++++
>  drivers/memory/tegra/tegra186.c     |   3 +
>  drivers/memory/tegra/tegra234.c     | 143 +++++++++++++++++++++++++++-
>  include/linux/tegra-icc.h           |  65 +++++++++++++
>  include/soc/tegra/mc.h              |   7 ++
>  6 files changed, 347 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/tegra-icc.h
> 
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index 9082b6c3763d..983455b1f98d 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/sort.h>
> +#include <linux/tegra-icc.h>
>  
>  #include <soc/tegra/fuse.h>
>  
> @@ -792,6 +793,8 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>  	mc->provider.data = &mc->provider;
>  	mc->provider.set = mc->soc->icc_ops->set;
>  	mc->provider.aggregate = mc->soc->icc_ops->aggregate;
> +	mc->provider.get_bw = mc->soc->icc_ops->get_bw;
> +	mc->provider.xlate = mc->soc->icc_ops->xlate;
>  	mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
>  
>  	icc_provider_init(&mc->provider);
> @@ -824,6 +827,8 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>  		err = icc_link_create(node, TEGRA_ICC_MC);
>  		if (err)
>  			goto remove_nodes;
> +
> +		node->data = (struct tegra_mc_client *)&(mc->soc->clients[i]);
>  	}
>  
>  	err = icc_provider_register(&mc->provider);
> diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
> index e935ad4e95b6..1eefcf2ac0c7 100644
> --- a/drivers/memory/tegra/tegra186-emc.c
> +++ b/drivers/memory/tegra/tegra186-emc.c
> @@ -7,9 +7,11 @@
>  #include <linux/debugfs.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  
>  #include <soc/tegra/bpmp.h>
> +#include "mc.h"
>  
>  struct tegra186_emc_dvfs {
>  	unsigned long latency;
> @@ -29,8 +31,15 @@ struct tegra186_emc {
>  		unsigned long min_rate;
>  		unsigned long max_rate;
>  	} debugfs;
> +
> +	struct icc_provider provider;
>  };
>  
> +static inline struct tegra186_emc *to_tegra186_emc(struct icc_provider *provider)
> +{
> +	return container_of(provider, struct tegra186_emc, provider);
> +}
> +
>  /*
>   * debugfs interface
>   *
> @@ -146,11 +155,104 @@ DEFINE_DEBUGFS_ATTRIBUTE(tegra186_emc_debug_max_rate_fops,
>  			  tegra186_emc_debug_max_rate_get,
>  			  tegra186_emc_debug_max_rate_set, "%llu\n");
>  
> +/*
> + * tegra_emc_icc_set_bw() - Set BW api for EMC provider
> + * @src: ICC node for External Memory Controller (EMC)
> + * @dst: ICC node for External Memory (DRAM)
> + *
> + * Do nothing here as info to BPMP-FW is now passed in the BW set function
> + * of the MC driver. BPMP-FW sets the final Freq based on the passed values.
> + */
> +static int tegra_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
> +{
> +	return 0;
> +}
> +
> +static struct icc_node *
> +tegra_emc_of_icc_xlate(struct of_phandle_args *spec, void *data)
> +{
> +	struct icc_provider *provider = data;
> +	struct icc_node *node;
> +
> +	/* External Memory is the only possible ICC route */
> +	list_for_each_entry(node, &provider->nodes, node_list) {
> +		if (node->id != TEGRA_ICC_EMEM)
> +			continue;
> +
> +		return node;
> +	}
> +
> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +
> +static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
> +{
> +	*avg = 0;
> +	*peak = 0;
> +
> +	return 0;
> +}
> +
> +static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
> +{
> +	struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
> +	const struct tegra_mc_soc *soc = mc->soc;
> +	struct icc_node *node;
> +	int err;
> +
> +	emc->provider.dev = emc->dev;
> +	emc->provider.set = tegra_emc_icc_set_bw;
> +	emc->provider.data = &emc->provider;
> +	emc->provider.aggregate = soc->icc_ops->aggregate;
> +	emc->provider.xlate = tegra_emc_of_icc_xlate;
> +	emc->provider.get_bw = tegra_emc_icc_get_init_bw;
> +
> +	icc_provider_init(&emc->provider);
> +
> +	/* create External Memory Controller node */
> +	node = icc_node_create(TEGRA_ICC_EMC);
> +	if (IS_ERR(node)) {
> +		err = PTR_ERR(node);
> +		goto err_msg;
> +	}
> +
> +	node->name = "External Memory Controller";
> +	icc_node_add(node, &emc->provider);
> +
> +	/* link External Memory Controller to External Memory (DRAM) */
> +	err = icc_link_create(node, TEGRA_ICC_EMEM);
> +	if (err)
> +		goto remove_nodes;
> +
> +	/* create External Memory node */
> +	node = icc_node_create(TEGRA_ICC_EMEM);
> +	if (IS_ERR(node)) {
> +		err = PTR_ERR(node);
> +		goto remove_nodes;
> +	}
> +
> +	node->name = "External Memory (DRAM)";
> +	icc_node_add(node, &emc->provider);
> +
> +	err = icc_provider_register(&emc->provider);
> +	if (err)
> +		goto remove_nodes;
> +
> +	return 0;

Blank line

> +remove_nodes:
> +	icc_nodes_remove(&emc->provider);
> +err_msg:
> +	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
> +
> +	return err;
> +}
> +
>  static int tegra186_emc_probe(struct platform_device *pdev)
>  {
>  	struct mrq_emc_dvfs_latency_response response;
>  	struct tegra_bpmp_message msg;
>  	struct tegra186_emc *emc;
> +	struct tegra_mc *mc;
>  	unsigned int i;
>  	int err;
>  
> @@ -158,6 +260,9 @@ static int tegra186_emc_probe(struct platform_device *pdev)
>  	if (!emc)
>  		return -ENOMEM;
>  
> +	platform_set_drvdata(pdev, emc);
> +	emc->dev = &pdev->dev;

This patch looks like stiched from two or more patches... emc->dev does
not look like new member of emc, thus why do you set in exisitng
function in this patch? Why it wasn't needed before?

Same about line before.

> +
>  	emc->bpmp = tegra_bpmp_get(&pdev->dev);
>  	if (IS_ERR(emc->bpmp))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(emc->bpmp), "failed to get BPMP\n");
> @@ -236,6 +341,25 @@ static int tegra186_emc_probe(struct platform_device *pdev)
>  	debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
>  			    emc, &tegra186_emc_debug_max_rate_fops);
>  
> +	mc = dev_get_drvdata(emc->dev->parent);
> +	if (mc && mc->soc->icc_ops) {
> +		/*
> +		 * Initialize the ICC even if BPMP-FW doesn't support 'MRQ_BWMGR_INT'.
> +		 * Use the flag 'mc->bwmgr_mrq_supported' within MC driver and return
> +		 * EINVAL instead of passing the request to BPMP-FW later when the BW
> +		 * request is made by client with 'icc_set_bw()' call.
> +		 */
> +		err = tegra_emc_interconnect_init(emc);
> +		if (err)
> +			goto put_bpmp;
> +
> +		if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT))
> +			mc->bwmgr_mrq_supported = true;
> +		else
> +

Drop blank line.

> +			dev_info(&pdev->dev, "MRQ_BWMGR_INT not present\n");

And what user is supposed to do with this? Either make it descriptive or
drop.

> +	}
> +
>  	return 0;
>  
>  put_bpmp:
> @@ -272,6 +396,7 @@ static struct platform_driver tegra186_emc_driver = {
>  		.name = "tegra186-emc",
>  		.of_match_table = tegra186_emc_of_match,
>  		.suppress_bind_attrs = true,
> +		.sync_state = icc_sync_state,
>  	},
>  	.probe = tegra186_emc_probe,
>  	.remove = tegra186_emc_remove,
> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
> index 7bb73f06fad3..386e029e41bb 100644
> --- a/drivers/memory/tegra/tegra186.c
> +++ b/drivers/memory/tegra/tegra186.c
> @@ -10,6 +10,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
> +#include <soc/tegra/bpmp.h>
>  #include <soc/tegra/mc.h>
>  
>  #if defined(CONFIG_ARCH_TEGRA_186_SOC)
> @@ -65,6 +66,8 @@ static int tegra186_mc_probe(struct tegra_mc *mc)
>  static void tegra186_mc_remove(struct tegra_mc *mc)
>  {
>  	of_platform_depopulate(mc->dev);
> +
> +	tegra_bpmp_put(mc->bpmp);
>  }
>  
>  #if IS_ENABLED(CONFIG_IOMMU_API)
> diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
> index 02dcc5748bba..4f34247c9bda 100644
> --- a/drivers/memory/tegra/tegra234.c
> +++ b/drivers/memory/tegra/tegra234.c
> @@ -1,18 +1,24 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (C) 2021-2022, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (C) 20212-2023, NVIDIA CORPORATION.  All rights reserved.

Typo, 2021.

>   */
>  
>  #include <soc/tegra/mc.h>
>  
>  #include <dt-bindings/memory/tegra234-mc.h>
> +#include <linux/interconnect.h>
> +#include <linux/of_device.h>

One more suprising change...

> +#include <linux/tegra-icc.h>
>  
> +#include <soc/tegra/bpmp.h>
>  #include "mc.h"
>  
>  static const struct tegra_mc_client tegra234_mc_clients[] = {
>  	{
>  		.id = TEGRA234_MEMORY_CLIENT_MGBEARD,
>  		.name = "mgbeard",
> +		.bpmp_id = TEGRA_ICC_BPMP_EQOS,
> +		.type = TEGRA_ICC_NISO,
>  		.sid = TEGRA234_SID_MGBE,
>  		.regs = {
>  			.sid = {


Best regards,
Krzysztof

