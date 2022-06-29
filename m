Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE5E560616
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 18:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiF2QoF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiF2QoD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 12:44:03 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA19C2CCAC
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 09:44:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h192so15864629pgc.4
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H6SDMsRMBFpIBVc64uIxAbw8HhGrz6w0VpurvPOqgsM=;
        b=E37c3grA1rBzm//lFsHFq0a6MEvdOJph9uYs3FQO1S8A6X3GdkgNphhA/C6P2kfvHI
         Z9lg3Mz12GVOO2ZhjOOKzktWjASYcaNGpIqcqxP190j8kEnP4ALnkN4Pr4WvOiO5a2qz
         +fPd3kGXalda8Z0nnf7k1O/MWlnMqVX3Vi379rTIfoUXcJq0QwGwES99n41Ui8zMsPeO
         I7qpItVN6Z8/GhxF5R/7Nka26QL1rRbcIvXROtDXJyqfS5Zw6ZRt0EXbmLr9V0dYI++w
         By5gG0xbyAEEhB1NwmMbVUPTjqUnazp5q43Fx4MkLYKlFj+P7IeotiTuwMt/bsLVuNL6
         Li+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H6SDMsRMBFpIBVc64uIxAbw8HhGrz6w0VpurvPOqgsM=;
        b=Yx4g72jnjJ0Sv/Si1T5y4G2GlSueaTKz21g75XzBtP/YLoDz+8LnJd4VG12ptW691d
         q5CQHKZUQtvGegV9WtGqHu8wQGED/8x9ahkDkBqzRu1ucnbQi8FP8igN+I69Dl2LG2vQ
         P7JQNMgDZKLOUUJbQuGHCONs6qjG+yM3GcAzZiLz2T4HKPLIXbdABe3PMyxf9mG2onuV
         aV0fzgDNEyWhWHt2Hhd3IM9JweTo54l+DP+CPvNyN9OMkcEPkONZWzt5mp0oG5nod9IN
         nCQzyKTiDb3tE57tiHNFxqSXb5TjRCJjUw3F7kMgu+CJvzWo1L3OWEH4CX0HESPtxEkT
         wL7w==
X-Gm-Message-State: AJIora/jblgTliM4bJJHLD1RnIOPDZcq/Q7L+c+IS8tbezSs/FkPAoX6
        5/RXOEVzPo3qx3zhIfXZOUkGPA==
X-Google-Smtp-Source: AGRyM1v+C9A3jaRc2Q1KV6w1TvaLeuYysn0eCdaDGnMabgdtlVm1AV+vGXDLImhGSxwXKw+9L5UhTA==
X-Received: by 2002:a63:fa56:0:b0:3fc:d3d2:ceac with SMTP id g22-20020a63fa56000000b003fcd3d2ceacmr3778194pgk.99.1656521041434;
        Wed, 29 Jun 2022 09:44:01 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id cu7-20020a056a00448700b00525373aac7csm11665197pfb.26.2022.06.29.09.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 09:44:00 -0700 (PDT)
Date:   Wed, 29 Jun 2022 10:43:57 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yicong Yang <yangyicong@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>, yangyicong@hisilicon.com,
        helgaas@kernel.org, lorenzo.pieralisi@arm.com,
        suzuki.poulose@arm.com, jonathan.cameron@huawei.com,
        robin.murphy@arm.com, leo.yan@linaro.org, mark.rutland@arm.com,
        will@kernel.org, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, john.garry@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
        prime.zeng@huawei.com, liuqi115@huawei.com, james.clark@arm.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com,
        alexander.shishkin@linux.intel.com, acme@kernel.org
Subject: Re: [PATCH v9 0/8] Add support for HiSilicon PCIe Tune and Trace
 device
Message-ID: <20220629164357.GA2018382@p14s>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <af6723f1-c0c5-8af5-857c-af9280e705af@huawei.com>
 <Yrms2cI05O2yZRKU@kroah.com>
 <e737393a-56dd-7d24-33d3-e935b14ba758@huawei.com>
 <Yrm4O+AFbgnoBVba@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrm4O+AFbgnoBVba@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 27, 2022 at 04:01:31PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 27, 2022 at 09:25:42PM +0800, Yicong Yang wrote:
> > On 2022/6/27 21:12, Greg KH wrote:
> > > On Mon, Jun 27, 2022 at 07:18:12PM +0800, Yicong Yang wrote:
> > >> Hi Greg,
> > >>
> > >> Since the kernel side of this device has been reviewed for 8 versions with
> > >> all comments addressed and no more comment since v9 posted in 5.19-rc1,
> > >> is it ok to merge it first (for Patch 1-3 and 7-8)?
> > > 
> > > I am not the maintainer of this subsystem, so I do not understand why
> > > you are asking me :(
> > > 
> > 
> > I checked the log of drivers/hwtracing and seems patches of coresight/intel_th/stm
> > applied by different maintainers and I see you applied some patches of intel_th/stm.
> > Should any of these three maintainers or you can help applied this?
> 
> I was hoping Mark would have a look, since he knows this ARM stuff
> better than me. But ISTR he's somewhat busy atm too. But an ACK from the
> CoreSight people would also be appreciated.
>

I'll spend some time on it next week.

Thanks,
Mathieu

> And Arnaldo usually doesn't pick up the userspace perf bits until the
> kernel side is sorted.
