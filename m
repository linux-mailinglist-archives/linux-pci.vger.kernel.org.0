Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A406F97DB
	for <lists+linux-pci@lfdr.de>; Sun,  7 May 2023 11:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjEGJLP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 May 2023 05:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjEGJLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 May 2023 05:11:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C1F3C14
        for <linux-pci@vger.kernel.org>; Sun,  7 May 2023 02:11:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so5158078a12.1
        for <linux-pci@vger.kernel.org>; Sun, 07 May 2023 02:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683450670; x=1686042670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJVeF+6z9/ggAVBD2uz3HdoqI651ez6nvvs/Z94Hn3E=;
        b=ge34Tv1nacy0JlU4TMCDkcjgWKAcwLxMPJ2dqttvd5QDmlGBDNjo3SDaU8jS089GVp
         97aXexc5Ub/WBVBLBKqwau9eKg4cPpITPJiu9XBXVv4sWtFkODGN+fZRYn0+Lwj78Wr9
         fOCcWeplDjReFtG1ZWY+8Gg2ComYyfme+ZItmqx1XGp1d+YGrInfxG3ssasguj6Cmj4I
         UTuYDaGVfumJ4RzEE9sZ+/IqtW0M5spGQAofcgx5AzDbXSrirbcMKLuMiR+Wcl3xBsCV
         HiX+k/H4PkUKmHdfKesGyx5UbqayeiVibn5DjwZLthhz+4P6ExoNcTFTN5AuH7Pamixs
         JCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683450670; x=1686042670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJVeF+6z9/ggAVBD2uz3HdoqI651ez6nvvs/Z94Hn3E=;
        b=AzGBsYbA2z+C68ZrBI3IyD+4DNl2/W0jKYSHXSeu6IVhIDOr80DCYIRnzgQDbnPgqM
         DDz4Ar0ySi8kFKouOi3zPAqXhp8RAheKd/4ClgKuXk4CDwbmQbviu2p0d4dVsjRI9bsG
         f5T9YClyXhwHgyqyeLItgswNPLFIi9rdVNomCQX9eW5HV7dBM3MXyuOk79TaRlZY2yMF
         010Wn4jLCkCRvPizyZ6sLuPy2KFvrfE34teYa1qPa89kyRijBmkIzhCBHQZs5PgGWD0M
         ilVQtYauQy4qBV+YHrWKMUXIwvPh8XBvWlhAhc9gwK5Z7RVWjsqPRAuMerEleGDjXtd0
         3Cdw==
X-Gm-Message-State: AC+VfDxyn1b4OrcgwLfSQVo3GoaYJGzg9ZhU3tvlr6SVIticx6kj/Nqn
        WIGm+ihGsZcu9VqGH9hOxcf41w==
X-Google-Smtp-Source: ACHHUZ56Cj45M5bkDI2Qkj+cfrrqHrRXimMDzax69r9LP0DJegFaXQGg0XWQuxCR+n66BEZ9LerK4Q==
X-Received: by 2002:a17:907:6d01:b0:957:29e5:1695 with SMTP id sa1-20020a1709076d0100b0095729e51695mr5594140ejc.65.1683450669593;
        Sun, 07 May 2023 02:11:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:183b:950f:b4d5:135a? ([2a02:810d:15c0:828:183b:950f:b4d5:135a])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b00965ec1faf27sm3024164ejb.74.2023.05.07.02.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 02:11:08 -0700 (PDT)
Message-ID: <10b32e55-4d28-5405-035e-c73a514c95e4@linaro.org>
Date:   Sun, 7 May 2023 11:11:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [Patch v7 1/8] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
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
 <7c6c6584-204a-ada1-d669-2e8bef50e5e5@linaro.org>
 <3071273b-b03b-5fc8-ffa1-9b18311a3a5d@nvidia.com>
 <5ab9687e-756d-f94b-b085-931d4ea534c1@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5ab9687e-756d-f94b-b085-931d4ea534c1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/04/2023 17:21, Sumit Gupta wrote:
> 
> 
> On 24/04/23 20:30, Sumit Gupta wrote:
>>
>>
>> On 24/04/23 19:18, Krzysztof Kozlowski wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 24/04/2023 15:13, Sumit Gupta wrote:
>>>> Add Interconnect framework support to dynamically set the DRAM
>>>> bandwidth from different clients. Both the MC and EMC drivers are
>>>> added as ICC providers. The path for any request is:
>>>>   MC-Client[1-n] -> MC -> EMC -> EMEM/DRAM
>>>>
>>> Thank you for your patch. There is something to discuss/improve.
>>>
>>>
>>>> +static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
>>>> +{
>>>> +     struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
>>>> +     const struct tegra_mc_soc *soc = mc->soc;
>>>> +     struct icc_node *node;
>>>> +     int err;
>>>> +
>>>> +     emc->provider.dev = emc->dev;
>>>> +     emc->provider.set = tegra_emc_icc_set_bw;
>>>> +     emc->provider.data = &emc->provider;
>>>> +     emc->provider.aggregate = soc->icc_ops->aggregate;
>>>> +     emc->provider.xlate = tegra_emc_of_icc_xlate;
>>>> +     emc->provider.get_bw = tegra_emc_icc_get_init_bw;
>>>> +
>>>> +     icc_provider_init(&emc->provider);
>>>> +
>>>> +     /* create External Memory Controller node */
>>>> +     node = icc_node_create(TEGRA_ICC_EMC);
>>>> +     if (IS_ERR(node)) {
>>>> +             err = PTR_ERR(node);
>>>> +             goto err_msg;
>>>> +     }
>>>> +
>>>> +     node->name = "External Memory Controller";
>>>> +     icc_node_add(node, &emc->provider);
>>>> +
>>>> +     /* link External Memory Controller to External Memory (DRAM) */
>>>> +     err = icc_link_create(node, TEGRA_ICC_EMEM);
>>>> +     if (err)
>>>> +             goto remove_nodes;
>>>> +
>>>> +     /* create External Memory node */
>>>> +     node = icc_node_create(TEGRA_ICC_EMEM);
>>>> +     if (IS_ERR(node)) {
>>>> +             err = PTR_ERR(node);
>>>> +             goto remove_nodes;
>>>> +     }
>>>> +
>>>> +     node->name = "External Memory (DRAM)";
>>>> +     icc_node_add(node, &emc->provider);
>>>> +
>>>> +     err = icc_provider_register(&emc->provider);
>>>> +     if (err)
>>>> +             goto remove_nodes;
>>>> +
>>>> +     return 0;
>>>> +
>>>> +remove_nodes:
>>>> +     icc_nodes_remove(&emc->provider);
>>>> +err_msg:
>>>> +     dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
>>>> +
>>>> +     return err;
>>>> +}
>>>> +
>>>>   static int tegra186_emc_probe(struct platform_device *pdev)
>>>>   {
>>>> +     struct tegra_mc *mc = dev_get_drvdata(pdev->dev.parent);
>>>>        struct mrq_emc_dvfs_latency_response response;
>>>>        struct tegra_bpmp_message msg;
>>>>        struct tegra186_emc *emc;
>>>> @@ -236,6 +339,29 @@ static int tegra186_emc_probe(struct 
>>>> platform_device *pdev)
>>>>        debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, 
>>>> emc->debugfs.root,
>>>>                            emc, &tegra186_emc_debug_max_rate_fops);
>>>>
>>>> +     if (mc && mc->soc->icc_ops) {
>>>> +             /*
>>>> +              * Initialize the ICC even if BPMP-FW doesn't support 
>>>> 'MRQ_BWMGR_INT'.
>>>> +              * Use the flag 'mc->bwmgr_mrq_supported' within MC 
>>>> driver and return
>>>> +              * EINVAL instead of passing the request to BPMP-FW 
>>>> later when the BW
>>>> +              * request is made by client with 'icc_set_bw()' call.
>>>> +              */
>>>> +             err = tegra_emc_interconnect_init(emc);
>>>> +             if (err)
>>>> +                     goto put_bpmp;
>>>> +
>>>> +             if (tegra_bpmp_mrq_is_supported(emc->bpmp, 
>>>> MRQ_BWMGR_INT)) {
>>>> +                     mc->bwmgr_mrq_supported = true;
>>>> +
>>>> +                     /*
>>>> +                      * MC driver probe can't get BPMP reference as 
>>>> it gets probed
>>>> +                      * earlier than BPMP. So, save the BPMP ref got 
>>>> from the EMC
>>>> +                      * DT node in the mc->bpmp and use it in MC's 
>>>> icc_set hook.
>>>> +                      */
>>>> +                     mc->bpmp = emc->bpmp;
>>>
>>> This (and ()) are called without any locking. You register first the
>>> interconnect, so set() callback can be used, right? Then set() could be
>>> called anytime between tegra_emc_interconnect_init() and assignment
>>> above. How do you synchronize these?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Currently, the tegra234_mc_icc_set() has NULL check. So, it will give 
>> this error.
>>   if (!mc->bpmp) {

How does it solve concurrent accesses and re-ordering of instructions by
compiler or CPU?

>>           dev_err(mc->dev, "BPMP reference NULL\n");
>>           return -ENOENT;
>>   }
>>
>> To fix, we can do the below change and swap the order. Please let me 
>> know if this sounds fine ?
>>   if (mc && mc->soc->icc_ops) {
>>           if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
>>                   mc->bwmgr_mrq_supported = true;
>>                   mc->bpmp = emc->bpmp;
>>           }
>>
>>           err = tegra_emc_interconnect_init(emc);
>>           if (err)
>>                   goto put_bpmp;
>>
>>   }
> Sorry, replied too soon. Missed setting "mc->bpmp" to NULL. Sharing new 
> proposed change. Please let me know if this looks OK.
> 
>   if (mc && mc->soc->icc_ops) {
>      if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
>              mc->bwmgr_mrq_supported = true;
>              mc->bpmp = emc->bpmp;
>      }
> 
>      err = tegra_emc_interconnect_init(emc);
>      if (err) {
>              mc->bpmp = NULL;
>              goto put_bpmp;

Sorry, I didn't check the code. I assume you should do it...

Best regards,
Krzysztof

