Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B78956FEC1
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiGKKT5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 06:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiGKKTX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 06:19:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946DBC54B0;
        Mon, 11 Jul 2022 02:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6227B80E9D;
        Mon, 11 Jul 2022 09:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725D8C34115;
        Mon, 11 Jul 2022 09:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657532164;
        bh=x2fi2zGInfkK5GE+FcEN4aq5PDm1AC+auRutxJljOnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=APPSS6ZpGlTYzPOIc+D3XQW2CwCGP/IMRIoXGA3p94HZpreF4yANALnJuMSBpqVP0
         vSm7hgwSlXenfgVMUcIXvnkEqamBoPmKoCyUX9ue8gQGxzyL9oy7MWQQ39FM5jF5Iu
         WtbLinKW1wzmJiFmoZ6AlsEkK51ueM81XBDJcSneGj6RdgLzaSgxT9ESXIYypqwK19
         7+IjxVGlla55+f5lxc0aWkHBbSib2zaAlAQGC4h7fiDfse10WKw3DYXuQJb4XwlrPE
         w1n/zpXtzalDhQcLaI0pERiSrm0cZIcjttn0erVCsO3+LXhYLCamVwGgG5EN4Od7DQ
         ZUlvLKPs83YOw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oAppk-0006d9-CX; Mon, 11 Jul 2022 11:36:05 +0200
Date:   Mon, 11 Jul 2022 11:36:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] dt-bindings: PCI: qcom: Add SC8280XP to binding
Message-ID: <YsvvBHtQKzQD8sRE@hovoldconsulting.com>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-5-johan+linaro@kernel.org>
 <20220709080053.GK5063@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709080053.GK5063@thinkpad>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 09, 2022 at 01:30:53PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 29, 2022 at 04:09:54PM +0200, Johan Hovold wrote:
> > Add the SC8280XP platform to the binding.
> > 
> > SC8280XP use four host interrupts for MSI routing so remove the obsolete
> > comment referring to newer chipsets supporting one or eight interrupts
> > (e.g. for backwards compatibility).
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Wondering why 4 on this SoC. Is this what added in downstream or you also
> verified it with IP documentation.

I don't have direct access to the IP docs, but I've verified it with
people who do.

Johan
