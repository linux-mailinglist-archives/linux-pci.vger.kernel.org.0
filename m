Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90894BC258
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 22:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbiBRVxx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 16:53:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbiBRVxx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 16:53:53 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85BE48328
        for <linux-pci@vger.kernel.org>; Fri, 18 Feb 2022 13:53:35 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p23so8982833pgj.2
        for <linux-pci@vger.kernel.org>; Fri, 18 Feb 2022 13:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZXhaWbIOXPQuT8HgBVIhKVVo55naTZ6jyJBspy9kt4=;
        b=CDiKJo+2jkhA827OSKNjg9iykVaGNhfa9oxg5fwXUWWCNQZOjLGAix7tO5YjzkL/Ss
         XMwD5IMw3t94TowotEMldgov1lqUr7dMrANeViPK8j0yxC1/vaiydq+2+98UMRxbBHbH
         fo3VqEeFUT3gyEFZXrIfl9rPjZDjZl/ITsoiPu1h8fgAep1fK3WuFDq0jsudLZM6eSZk
         M32r6xV4d3PfvU+pD5osbN2GgyZkkHunjiUp9WGAvtN//QK/o2WIkWCvm46q5zhaKm51
         Nay0QA1OOLi/CLSCOOGaeSyQzqPPgaydnbGIhQS4WjZ1JLu3MQmn3HCXr34rAVyzIH8p
         xr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZXhaWbIOXPQuT8HgBVIhKVVo55naTZ6jyJBspy9kt4=;
        b=pRBR+2CcTNd6jQIAFvnfuPmcGw5WA2imuVVQBsJPv1jtx3vRs/+YDKM2HMkSlPb5Qz
         qUvLfzJGHY+8aAcrlEC9dWws/n4iIypKwfww3GKdd3p5rp1rOuPUTL/410XTupkvNyFA
         jWCcHok85/jimlIRtAazkRaFo7BF2YPTHH4yqHBAizZMzUzLM/UEycLRamm3Omj2mNJn
         5PB9hgl/KY9gtzXOoG7MgG0Lice7E46VlurbJT9SqFLZrsNRzRFmz5HVrv/hLa5iXnPy
         9E9l3LLfkrqu7bzBPdQzBxnQclVnI44QlfHGfLlERA+VFLoH7xExtjmakYbb+wJjfL1Y
         R/VA==
X-Gm-Message-State: AOAM530nH/WFFiCtQUpi1L5mVsu92KGiuZSzvOZpNg3Wf56dhQDymSEa
        e0KaJVKWy4j24VBXiaFLSE89Un1KS/Y3NE21f3BGm09PSjA=
X-Google-Smtp-Source: ABdhPJy5ssiXYUNonyfu/HjJBCdDQCLxCIw8UJpjcjS1wK2sHSvuZZeBneLbc0kOqNe87wUfmX2j7YIiihiYLa2Igmo=
X-Received: by 2002:a05:6a00:8ca:b0:4e0:2ed3:5630 with SMTP id
 s10-20020a056a0008ca00b004e02ed35630mr9561872pfu.3.1645221215341; Fri, 18 Feb
 2022 13:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com> <20220128002707.391076-10-ben.widawsky@intel.com>
In-Reply-To: <20220128002707.391076-10-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Feb 2022 13:53:24 -0800
Message-ID: <CAPcyv4gA+iimMxGay2ri9eceOrYr_5Hhjfomzh910rQExOtoKg@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] cxl/region: Add infrastructure for decoder programming
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> There are 3 steps in handling region programming once it has been
> configured by userspace.
> 1. Sanitize the parameters against the system.
> 2. Collect decoder resources from the topology
> 3. Program decoder resources
>
> The infrastructure added here addresses #2. Two new APIs are introduced
> to allow collecting and returning decoder resources. Additionally the
> infrastructure includes two lists managed by the region driver, a staged
> list, and a commit list. The staged list contains those collected in
> step #2, and the commit list are all the decoders programmed in step #3.

I expect this patch will see significant rewrites with the ABI change
to register endpoint decoders with regions. It's otherwise redundant
to have a 'targets' array and then yet mosre linked lists to walk the
decoders associated with a region.
