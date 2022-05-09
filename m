Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865AB51F9E5
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 12:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiEIKdw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 06:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiEIKdQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 06:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAAF2A470F;
        Mon,  9 May 2022 03:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F28860F88;
        Mon,  9 May 2022 10:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3A1C385A8;
        Mon,  9 May 2022 10:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652092097;
        bh=PlFy/07hAa17TMhq+aNCgWbCDsl8/r7e+w5Jj0Q2ygY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmfobMHPaQSJAhtJajnXhcqR4P7Mk6+YyPBGBtEzjmNh3aFZ9Iz1YtJEeEgLAIaaj
         8UUKLXrvjwIgxieq0YSD72NELyeYjCm+HlUAqfYc9KXL+/oDVvSQxxgulm2x250ABg
         M6DinvLFSBVXb0Q3IPXBm9s9r4veVHsh/ngP1lEbNqGOgR/TLhCUAEel1ba7x/koPr
         FvqYNvMON/H4Ujkrztg5w0BAN7WOYyRrtTYY+9A/NeyVZSGsx+jhAM3agTuAtmtsI8
         A31zcptLJhsj3g/N1zuFrlm7aEuO/NhhyUFgrEINFQQ3KOLjtWDkryv9fh/8oH6xlO
         dhSgUzakRhyww==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1no0cg-0006CG-Ky; Mon, 09 May 2022 12:28:14 +0200
Date:   Mon, 9 May 2022 12:28:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/5] clk: qcom: regmap: add pipe clk implementation
Message-ID: <Ynjsvuo4p3jMoNEq@hovoldconsulting.com>
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
 <20220501192149.4128158-3-dmitry.baryshkov@linaro.org>
 <YnUVCCXybHUSAYx2@hovoldconsulting.com>
 <1b32940e-e402-6196-fd7e-0e34a7a18495@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b32940e-e402-6196-fd7e-0e34a7a18495@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 06, 2022 at 03:40:18PM +0300, Dmitry Baryshkov wrote:
> On 06/05/2022 15:31, Johan Hovold wrote:

> > The only thing that comes to mind that wouldn't be possible is to
> > set the mux state using an assigned clock parent in devicetree to make
> > sure that XO is always selected before toggling the GDSC at probe.
> > 
> > But since that doesn't seem to work anyway when the boot firmware has
> > set things up (e.g. causes a modem here to reset) that would probably
> > need to be handled in the GDSC driver anyway (i.e. make sure the source
> > is XO before enabling the GDSC but only when it was actually disabled).
> > 
> > Taking that one step further would be to implement all this in the GDSC
> > driver from the start so that the PHY PLL is always muxed in while the
> > power domain is enabled (and only then)...
> 
> I think, if we move this to the gdsc driver, we'd loose the part of the 
> clock tree.

Not necessarily, if the GDSC is modeled as a consumer of the mux. 

> If you don't mind, I'll wait for your Tested-by and will post the rename 
> patchset afterwards.

I've tested the series and it works as expected. I'll retest the final
version before giving my Tested-by.

Johan
