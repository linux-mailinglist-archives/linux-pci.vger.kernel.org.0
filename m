Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B306ECF8C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjDXNtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjDXNsj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 09:48:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A1F9EDD
        for <linux-pci@vger.kernel.org>; Mon, 24 Apr 2023 06:48:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5058181d58dso7937367a12.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Apr 2023 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682344107; x=1684936107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OICz6+capf7cuLGRkoyh1qbEASXYaa1MZU6VvGiVato=;
        b=ZMeGjKlomt2iVACb5S83+zdTVQvIHZxraEYqBRNmmYD/oL6fXL9AkjG2lFFAPpivR2
         AluNXC8g1SYj7RkHVFoVIw0pD7ZwSgwvsdHjK0F097ssF8VMO7Ijhyw2PQzdsJq4522O
         sP1Y9rRaWGe82gUg2FipyquvnUhgQWNx7naF0HGVEFkb+SGvpCk/PqMEVTGaT2Nyx7Ew
         JNP0OR9gtugabLPkcmz4lNy9fnhPkRUxI/8y7gGJAh+Ro+VP7NFeK2mybuiu+lrLO80r
         h2pSS+ow7Sa0g8Xc9ubRrgnWS8h8zQ9RoJqQX92pQPQlrGExugMsgUn5Pt0Yf4wzknYQ
         iDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682344107; x=1684936107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OICz6+capf7cuLGRkoyh1qbEASXYaa1MZU6VvGiVato=;
        b=daU/M2BXW2M2ruq1spGzCHQw2fK4bHNbtH+IPJhWpE8zS285BBAHVRZj4IdB/bR/Zk
         EAj76qphe1irC+ZF6JLfPd5ZVLbqY6wNSrJD9fIiexPgX6yxtPDcc55kctVs0J+11zWo
         V7VDUrlTSfgBmFfHGf9cp90XiJve8kjVpEQAfosUWh0tAKaVH1qY5XSfbYsU4moiwhoR
         kReRhuQ8BHKXf+zrYIFsXqQIOPJ4Mxp4PX05+OqqUWpyRc5XPD8IBjap8XWA2PhBQ3An
         96mkLV/ium7Pqa7WaOuNLYnfEYMdr4VN1fEV0H0mZkn08jH/nZqEL747x5sP2TnGQRYM
         6ZpQ==
X-Gm-Message-State: AAQBX9c6CybBvS5pxA3FvTIou8YWWfgrlIxSoj9+fI8qnHOgEJdT3RFY
        jxBuAIAsIG1OFKgabu5r4dsrL8NnV1/LMTtLMuM2yA==
X-Google-Smtp-Source: AKy350Z2rB/JGRXOHyK6SBVvOl3r1WgCRC5q0/nMxjjZTatSqtPJEuTYj1DWJetOUSyaDAMX9IgHMg==
X-Received: by 2002:aa7:ca4e:0:b0:506:b2a3:a8cd with SMTP id j14-20020aa7ca4e000000b00506b2a3a8cdmr10571058edt.40.1682344107632;
        Mon, 24 Apr 2023 06:48:27 -0700 (PDT)
Received: from [10.105.146.163] ([88.128.92.195])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b0094e96e46cc0sm5489726ejz.69.2023.04.24.06.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 06:48:27 -0700 (PDT)
Message-ID: <7c6c6584-204a-ada1-d669-2e8bef50e5e5@linaro.org>
Date:   Mon, 24 Apr 2023 15:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Patch v7 1/8] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        lpieralisi@kernel.org, helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com, kw@linux.com,
        bhelgaas@google.com, vidyas@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, ishah@nvidia.com, bbasu@nvidia.com
References: <20230424131337.20151-1-sumitg@nvidia.com>
 <20230424131337.20151-2-sumitg@nvidia.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230424131337.20151-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/04/2023 15:13, Sumit Gupta wrote:
> Add Interconnect framework support to dynamically set the DRAM
> bandwidth from different clients. Both the MC and EMC drivers are
> added as ICC providers. The path for any request is:
>  MC-Client[1-n] -> MC -> EMC -> EMEM/DRAM
> 
Thank you for your patch. There is something to discuss/improve.


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
> +
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
> +	struct tegra_mc *mc = dev_get_drvdata(pdev->dev.parent);
>  	struct mrq_emc_dvfs_latency_response response;
>  	struct tegra_bpmp_message msg;
>  	struct tegra186_emc *emc;
> @@ -236,6 +339,29 @@ static int tegra186_emc_probe(struct platform_device *pdev)
>  	debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
>  			    emc, &tegra186_emc_debug_max_rate_fops);
>  
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
> +		if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
> +			mc->bwmgr_mrq_supported = true;
> +
> +			/*
> +			 * MC driver probe can't get BPMP reference as it gets probed
> +			 * earlier than BPMP. So, save the BPMP ref got from the EMC
> +			 * DT node in the mc->bpmp and use it in MC's icc_set hook.
> +			 */
> +			mc->bpmp = emc->bpmp;

This (and ()) are called without any locking. You register first the
interconnect, so set() callback can be used, right? Then set() could be
called anytime between tegra_emc_interconnect_init() and assignment
above. How do you synchronize these?

Best regards,
Krzysztof

