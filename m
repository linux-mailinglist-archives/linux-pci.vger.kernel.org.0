Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939E17EF11C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 11:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjKQKyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 05:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQKyP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 05:54:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEF911D;
        Fri, 17 Nov 2023 02:54:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16693C433C8;
        Fri, 17 Nov 2023 10:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700218451;
        bh=OXBOLq2qavNwBO+KZhgrHWI3M3WMeSyFpV1K9FpnvdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGyK4ktJ1n1a6abGVywZCpKGadO+xmyfTspqaCZtXvEOa/Ln1SJJsFd4qrVWtrpJm
         Hg7pxLRPw3JIf4x++7oOI8PP99DYAV7ZqsuWSebHL6Yi4ZSkO9SSTBY+msB5jjR7tN
         HMl9ixhVk5BVcDLz76KwVy1hSbXtSXmWiCVHlftWsDYlNmU7CZ79OO/w8iTRKe6bdU
         9NFszLctvAbEUGDjN3MPfwZ+4W/Tzn4xEAJ55qad6Yn+a0E87C1l6gQMKHfCpjgAEz
         zcQOTMEvWYznoC2EmJBGTVpLE+1teiWLsmI4xh+iyzIDxCwf/SEQntsE2w2wlLQxsp
         8BlLLUU4bUchQ==
Date:   Fri, 17 Nov 2023 16:24:04 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI: qcom: Clean up ASPM comment
Message-ID: <20231117105404.GR250770@thinkpad>
References: <20231114135553.32301-1-johan+linaro@kernel.org>
 <20231114135553.32301-5-johan+linaro@kernel.org>
 <20231117103227.GM250770@thinkpad>
 <ZVdE6nqanqcaL8sO@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVdE6nqanqcaL8sO@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 17, 2023 at 11:48:10AM +0100, Johan Hovold wrote:
> On Fri, Nov 17, 2023 at 04:02:27PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Nov 14, 2023 at 02:55:51PM +0100, Johan Hovold wrote:
> > > Break up the newly added ASPM comment so that it fits within the soft 80
> > > character limit and becomes more readable.
> > > 
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> > I think we discussed (80column soft limit for comments) in the past, but I don't
> > think breaking here makes the comment more readable.
> 
> The coding style clearly states:
> 
> 	The preferred limit on the length of a single line is 80 columns.
> 
> 	Statements longer than 80 columns should be broken into sensible chunks,
> 	unless exceeding 80 columns significantly increases readability and does
> 	not hide information.
> 
> Going beyond 80 chars may sometimes be warranted for code, but the
> exception is not intended for comments.
> 

Breaking the comment here is indeed making it hard to read. It's just one word
that needs to be broken if we go by 80 column limit and I won't prefer that,
sorry!

- Mani

> Johan

-- 
மணிவண்ணன் சதாசிவம்
