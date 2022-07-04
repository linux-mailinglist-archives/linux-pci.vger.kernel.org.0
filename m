Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D600565854
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 16:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiGDOKq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiGDOKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 10:10:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978D46475;
        Mon,  4 Jul 2022 07:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59CC1B80D1A;
        Mon,  4 Jul 2022 14:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A723C341C7;
        Mon,  4 Jul 2022 14:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656943843;
        bh=nlgUGEBRbk87Xq0tkttoZF5H/4JVQ7LmBsJr6/4fROw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNiFEdpa7R5GCHOTKy8gbsWUkc60yK+FuczJnANH+mFKdHBBEqulbI36mg2RV/bZC
         r/jZK0YgbOA7ucYhejIi4qYEQ8dWp1nf3EGdERVgx3GV6EN77ZkPSRjyPcdpw+beEL
         p7JQwoHRMibkQJiUh2u4oUX0v+eHWCDDlnn5MK729sabogyizcqYHvYjb0IVkT3KjP
         DRz9t2T7ciOgac2sizLBgRMVtKvtwYH6poQrPnNXueCaSXjd7JS3diWWhwtQITMlNm
         h1s4+3l17Dcvj0s31MsG+92xKjHrUJeCr7Jee0PrC2PpzS7BUD33vL1S2DI3rgh+zX
         ffQ3a8lW5WpnQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8Mmh-0006lM-7e; Mon, 04 Jul 2022 16:10:43 +0200
Date:   Mon, 4 Jul 2022 16:10:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] PCI: qcom: Add support for SC8280XP
Message-ID: <YsL0464vyNHoyAoY@hovoldconsulting.com>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-7-johan+linaro@kernel.org>
 <20220701182909.GA1266081-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701182909.GA1266081-robh@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 12:29:09PM -0600, Rob Herring wrote:
> On Wed, Jun 29, 2022 at 04:09:56PM +0200, Johan Hovold wrote:
> > The SC8280XP platform has seven PCIe controllers: two used with USB4,
> > two 4-lane, two 2-lane and one 1-lane.
> > 
> > Add a new "qcom,pcie-sc8280xp" compatible string and reuse the 1.9.0
> > ops.
> > 
> > Note that the SC8280XP controllers need two or three interconnect
> > clocks to be enabled. Model these as optional clocks to avoid encoding
> > devicetree data in the PCIe driver.
> 
> Shouldn't the interconnect binding handle these? Probably, bus clocks 
> have to be the biggest single reason why clocks are such a mess in terms 
> of 'the same' block having different clocks.

I fully agree, but I ended up following the current scheme of letting
the driver manage these, partly as I lack documentation for the
interconnect. 

Note that two interconnect clocks were recently included in the SM8450
binding:

	https://lore.kernel.org/all/YcIwcUzYCq1v4Kfs@robh.at.kernel.org/

and that the generically sounding clock names chosen make it tempting to
repurpose them:

	https://lore.kernel.org/all/1656691899-21315-4-git-send-email-quic_krichai@quicinc.com/

which seems like another step backwards.

For MSM8996, it looks like this was instead handled by never disabling
the interconnect clocks: 

	https://lore.kernel.org/all/20171207105922.31986-1-srinivas.kandagatla@linaro.org/

Johan
