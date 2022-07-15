Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1909A575D0D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 10:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiGOIJN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 04:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiGOIJL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 04:09:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CA91CB0E;
        Fri, 15 Jul 2022 01:09:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso5460905pjo.0;
        Fri, 15 Jul 2022 01:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rdXFs9dhHEmYQ1p1ijyoJFheXKNT53wMg7gaHyHajRs=;
        b=CMwx5eWilpke9A9U9PysLhgq3oj9UQNtzcPAIT+GD2mwU7iJ5D9avNU4vepTupSqT5
         Ry3WSe6U/gq91OuuORRb/PwxDxIV46EJ7yJtaxAgQnMfIv3ns8Y76socd7HtbYnes/vY
         gibUanTNA1O/GuZaS6JvJ41aRLNRg6pFANQTP24fE9L2XNNlM00uKjaaYS59npH5iPf1
         e6OGfvh9tPZwT4KJuDGDUYA5y0SfexTeU8QJaDPgdkA+SzVPJIZb666muYMf6uLfXwSr
         Hp/flc16jmPROVMcXhQsS+ZXEY0+VF+sPF6rWzjq8zenyPKrFXYq/ExiPuHJc85+s8F0
         1yrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rdXFs9dhHEmYQ1p1ijyoJFheXKNT53wMg7gaHyHajRs=;
        b=pOZtfQdhoe4xW5lrU22I796qCbgFuJ1KjHNUujHuFClYe4BSVgDOl08otnGKwRQpfD
         f0+5s8Myn6FgW5LtYorMKf3NNiVul/epfkfAylZYOlNSVYCPD6eSG3QDBGoAL73qkTye
         Nu0dk9bEb8DyKmVfD7jxCfSOYwMhiUa/PM2w7CHyXlkQ6f7F7M6RSmYXWBSGL958eurX
         eD2/zRsUvZjlzy4Z5Z+JCfpmO5kRCb2v4k723DTlbF3iztrNzRGp+8QkqveMDBS0VXG+
         Vw8zIFpCv0eHHxL7Bt1EnfngrtH+SYqltTvq6ejSkAhelYbRfVbdlPK6+q6ceQcbxbtF
         elcw==
X-Gm-Message-State: AJIora84k56Khabpop5hRdWgGTGiGD8mTUtZ4HktZqbJ8sxGE1Bi9B0E
        QzJdGCWRJtqSoF1M6fb2PVc=
X-Google-Smtp-Source: AGRyM1srfbhQP54d3VOBFEBlurpmpSM2rwsylrne55YbDoqcDEgAyDzopM+ftR3vmVuJpDXcCkXP2Q==
X-Received: by 2002:a17:90b:1bc7:b0:1f0:34e2:5c86 with SMTP id oa7-20020a17090b1bc700b001f034e25c86mr13954875pjb.136.1657872550151;
        Fri, 15 Jul 2022 01:09:10 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-22.three.co.id. [180.214.232.22])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78e85000000b00525b61f4792sm3073193pfr.109.2022.07.15.01.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 01:09:09 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 601A51008E0; Fri, 15 Jul 2022 15:09:06 +0700 (WIB)
Date:   Fri, 15 Jul 2022 15:09:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, alexander.shishkin@linux.intel.com,
        leo.yan@linaro.org, james.clark@arm.com, will@kernel.org,
        robin.murphy@arm.com, acme@kernel.org, peterz@infradead.org,
        corbet@lwn.net, mathieu.poirier@linaro.org, mark.rutland@arm.com,
        jonathan.cameron@huawei.com, john.garry@huawei.com,
        helgaas@kernel.org, lorenzo.pieralisi@arm.com,
        suzuki.poulose@arm.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-doc@vger.kernel.org, prime.zeng@huawei.com,
        liuqi115@huawei.com, zhangshaokun@hisilicon.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v10 7/8] docs: trace: Add HiSilicon PTT device driver
 documentation
Message-ID: <YtEgoZveaZJ3a7+4@debian.me>
References: <20220714092710.53486-1-yangyicong@hisilicon.com>
 <20220714092710.53486-8-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220714092710.53486-8-yangyicong@hisilicon.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 05:27:09PM +0800, Yicong Yang wrote:
> +1. Tx path QoS control
> +------------------------
> +
<snip>
> +2. Tx path buffer control
> +-------------------------
> +

Shouldn't Tx in the headings above be lowercase (tx)?

> +1. filter
> +---------
<snip>
> +2. type
> +-------
<snip>
> +3. direction
> +------------
<snip>
> +4. format
> +--------------
<snip>
> +5. memory management
> +--------------------
<snip>
> +6. decoding
> +-----------

I think these headings above should use title case instead.

Anyway, the documentation (htmldocs) builds successfully without new
warnings.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
