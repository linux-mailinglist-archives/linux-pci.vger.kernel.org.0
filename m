Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C69694F68
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 19:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBMSdB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 13:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBMSdA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 13:33:00 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62B013DE1;
        Mon, 13 Feb 2023 10:32:58 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id oa11-20020a17090b1bcb00b002341a2656e5so1581344pjb.1;
        Mon, 13 Feb 2023 10:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNk3UELDGb/VaGugwXVxHzDA5RNRGF2dh5FGqDHZODo=;
        b=TTFnzO1dJz85kCeHttfYg/BxqDzpw1FA3a05wiVvlj6tP3hQhPtAPBxfAfeyjVKWlY
         MpXgJt2deNy7HFhwEpc21IjjeFrL6LCgacGYloriA4ESSvIF7sxiPdJxEwqPi/vVFSD6
         iPIVcca/Fr4gNWHB67Pm3ZYk28TSC71SXWhzvqHGNI+lBSeZISsyepoisjUd09yr/UKk
         RtURFpdMey+UO85tr+3mp3BpUiXWN9OOrWSjj/gbEwZvf4/eEMOoTSBewUt2xfRasGg2
         99nXlf3Dnfc9FMTYrnZhg6Ivuj6CHrQuRm4k98XFIdOxe5ilmVhSKJeLJcN7YiDzt08H
         34Yg==
X-Gm-Message-State: AO0yUKWI4nfBidMSSnPJz3qFlq4qGCMVRkzmm9MLfFVJRY0BvDaZegV/
        nXJ74aA47kRal8IK2qs/aXg=
X-Google-Smtp-Source: AK7set8bqfAEsgoBzYy8J6ejBneEGYS/nL6hiIntMGR8g21NqX+cFWzSDRIL7ZHXcO32eieVSJk5Sg==
X-Received: by 2002:a17:902:c942:b0:19a:aea3:8a92 with SMTP id i2-20020a170902c94200b0019aaea38a92mr1709128pla.16.1676313178378;
        Mon, 13 Feb 2023 10:32:58 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f7cd00b0019a87514e00sm4527517plw.177.2023.02.13.10.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:32:57 -0800 (PST)
Date:   Tue, 14 Feb 2023 03:32:54 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-pci@vger.kernel.org, kishon@kernel.org,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, robh@kernel.org, vidyas@nvidia.com,
        vigneshr@ti.com
Subject: Re: [PATCH v5 0/5] PCI: endpoint: Rework the EPC to EPF notification
Message-ID: <Y+qCVuGdlCeUR2Ro@rocinante>
References: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
 <20230124071602.GB4947@thinkpad>
 <20230213065718.GA4375@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230213065718.GA4375@thinkpad>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> > > During the review of the patch that fixes DBI access in PCI EP, Rob
> > > suggested [1] using a fixed interface for passing the events from EPC to
> > > EPF instead of the in-kernel notifiers.
> > > 
> > > This series introduces a simple callback based mechanism for passing the
> > > events from EPC to EPF. This interface is chosen for satisfying the below
> > > requirements:
> > > 
> > > 1. The notification has to reach the EPF drivers without any additional
> > > latency.
> > > 2. The context of the caller (EPC) needs to be preserved while passing the
> > > notifications.
> > > 
> > > With the existing notifier mechanism, the 1st case can be satisfied since
> > > notifiers aren't adding any huge overhead. But the 2nd case is clearly not
> > > satisfied, because the current atomic notifiers forces the EPF
> > > notification context to be atomic even though the caller (EPC) may not be
> > > in atomic context. In the notification function, the EPF drivers are
> > > required to call several EPC APIs that might sleep and this triggers a
> > > sleeping in atomic bug during runtime.
> > > 
> > > The above issue could be fixed by using a blocking notifier instead of
> > > atomic, but that proposal was not accepted either [2].
> > > 
> > > So instead of working around the issues within the notifiers, let's get rid
> > > of it and use the callback mechanism.
> > > 
> > > NOTE: DRA7xx and TEGRA194 drivers are only compile tested. Testing this series
> > > on the real platforms is greatly appreciated.
> > > 
> > 
> > Lorenzo, all patches in this series got review tags. Can you please merge now?
> > 
> 
> Krzysztof, any update on this series?

Sorry for the late reply.  I just realised that my question from a few days
ago has yet to make it to the mailing list. Again, I apologise for keeping
you waiting.


Nevertheless, I was asking whether there would be any "Fixes:" tags to add
and if we should let the stable maintainers know since this fixes an issue
that might be worth back-porting to older kernels.


Let me know.  Otherwise, everything looks good!  Thank you a lot!
 
	Krzysztof
