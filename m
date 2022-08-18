Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55F8597A9D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 02:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiHRA1I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 20:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiHRA1H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 20:27:07 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E580A61EE
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 17:27:03 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 24so38595pgr.7
        for <linux-pci@vger.kernel.org>; Wed, 17 Aug 2022 17:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=PvIYXw+Faiu3KVVp5iV7apyrDn9c6HRBVSNqHnasOHg=;
        b=AisgDSPBhkYxrjX+sBqS7eD184nCV16iuDgJoWV7GLmyMhb0e2QyGKmb6iN5kIUxu0
         /e76G7Nc/bpGxUJei2d04dy7Uqui//IPOcqaIpRGo6D+RTgQSZsah5BUU8/qo1snyTMB
         lqiaUSK13xHVFAZIXhU1qkmDUIjo5FIygKoLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PvIYXw+Faiu3KVVp5iV7apyrDn9c6HRBVSNqHnasOHg=;
        b=NiqkiFpfgmBZ/6Fykr5MJPdckoDpf8Ag/sePnPhEuzl2sxbRaDXEGkXxAd6HTJzoJh
         KyHPOI5LPW5D8ur/aUfcccLBkAYyz5GGVToU466J3jWFsUJCEW6HVcuKsddZOYVIMqQ2
         mpCixOmZC8OhmfQ6IpQ9qVlYxJHiyPdSQ/zj0CRZgYv5EmpEoJWnYqe5AfIkA7+SESIi
         +Vk5123rTKwwFxzJjymOgVD+WJlU0otiyA+671c2A+WvuTzj76W5jdmXJUteHwXamPsZ
         zwJ5XKBjtU1z3C3Tv5Crcsz+d4AdYV7bZymkTI6z35F00lDzDRzS6l8CCBfSnXETUnIc
         f0gQ==
X-Gm-Message-State: ACgBeo3IwTK79ArvFjH0XTvTbXjslvFZueaR7Cd+CjsoFo7jVGnnudXT
        ajMYgdNGnxjDVqDvWHP4cW/3Vw==
X-Google-Smtp-Source: AA6agR5p+vnGAiifkH+g+BqUVl4qS4ozKPHYt4Gi1g/wA1WGMfNGB0IHKl+VtjoCZ97c4c7QtLDugQ==
X-Received: by 2002:a05:6a00:ac4:b0:535:c08:2da7 with SMTP id c4-20020a056a000ac400b005350c082da7mr590431pfl.69.1660782422992;
        Wed, 17 Aug 2022 17:27:02 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:536d:1358:1673:4c2d])
        by smtp.gmail.com with UTF8SMTPSA id cu14-20020a17090afa8e00b001f23db09351sm102358pjb.46.2022.08.17.17.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 17:27:02 -0700 (PDT)
Date:   Wed, 17 Aug 2022 17:27:00 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Sajid Dalvi <sdalvi@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/PM: Switch D3Hot delay to also use usleep_range
Message-ID: <Yv2HVLGdnNj/fwSG@google.com>
References: <20220817230821.47048-1-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220817230821.47048-1-willmcvicker@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 17, 2022 at 11:08:21PM +0000, Will McVicker wrote:
> From: Sajid Dalvi <sdalvi@google.com>
> 
> Since the PCI spec requires a 10ms D3Hot delay (defined by
> PCI_PM_D3HOT_WAIT) and a few of the PCI quirks update the D3Hot delay up
> to 120ms, let's add support for both usleep_range and msleep based on
> the delay time to improve the delay accuracy.
> 
> This patch is based off of a commit from Sajid Dalvi <sdalvi@google.com>
> in the Pixel 6 kernel tree [1]. Testing on a Pixel 6, found that the
> 10ms delay for the Exynos PCIe device was on average delaying for 19ms
> when the spec requires 10ms. Switching from msleep to uslseep_range
> therefore decreases the resume time on a Pixel 6 on average by 9ms.
> 
> [1] https://android.googlesource.com/kernel/gs/+/18a8cad68d8e6d50f339a716a18295e6d987cee3
> 
> Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
