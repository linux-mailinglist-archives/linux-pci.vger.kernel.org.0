Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179A7583506
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 00:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiG0WC1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 18:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiG0WC0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 18:02:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D84F6BB;
        Wed, 27 Jul 2022 15:02:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F42BB82282;
        Wed, 27 Jul 2022 22:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6E6C433D6;
        Wed, 27 Jul 2022 22:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658959342;
        bh=JHxLD7adE29C3PTZwVw6TG/arziY/IL7wPNO7oLQuoo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cD8DGlrfRJFeJlWrRdjqTpGlsBiWus7K4m/IXrCbhThL3ipJaa1SJhgU790eSrBud
         vjDg+rAG4+E28DQyY9eYH0a4HeM+5HTORjsu6zLxnjk0Gi2/qL4BBWXUxMk7T+udx8
         OJeIvFGjXR8ja6ziFri8PnSQWqcn5Nm54xDv4bS9e4Z87zRsv9k5bwDsShEds1jYFt
         ZB2KY+AJUKFDuJDMHKOM5ldwXXDibRqbDRulftn2DDtb4c61J12vhcLZ4q0DTo6PKf
         Hcjeq3ivadB9CgRmpcYkYBHH5ry+Xb8q6nWMkc+KN8mOKuCpSvbgeTj5AfTs4ONTZL
         ehBHAtVexcNAg==
Date:   Wed, 27 Jul 2022 17:02:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Baruch Siach <baruch.siach@siklu.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: qcom: Sort variants by Qcom IP rev
Message-ID: <20220727220220.GA218338@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt/h7q9OBtlyG+Sw@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 26, 2022 at 02:45:34PM +0200, Johan Hovold wrote:
> On Fri, Jul 22, 2022 at 10:49:19AM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Previously the variant resource structs, ops, etc., were in no obvious
> > order (mostly but not consistently in *Synopsys* IP rev order, which is not
> > reflected in the naming).
> > 
> > Reorder them in order of the struct and function names.  No functional
> > change intended.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 732 ++++++++++++-------------
> >  1 file changed, 366 insertions(+), 366 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index c27e3494179f..d0237d821323 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> 
> Moving code around like this makes code forensics harder as it messes up
> git blame. At least the callbacks appears to be grouped by IP version
> currently, so not sure how much you gain from moving the callbacks
> around.

The existing hodge-podge is sloppy and makes code reading harder for
everybody.  If we want them grouped by IP version, they should be
*named* by IP version.

> > -static const struct qcom_pcie_cfg sc8180x_cfg = {
> > -	.ops = &ops_1_9_0,
> > -	.has_tbu_clk = true,
> > -};
> > -
> >  static const struct qcom_pcie_cfg ipq6018_cfg = {
> >  	.ops = &ops_2_9_0,
> >  };
> 
> But this bit I disagree with. Why sort the SoCs configurations by IP
> revision, when what you typically need is to look them up by name?

Makes sense.

> Also note that this conflicts with my sc8280xp-support and IP-revision
> series:
> 
> 	https://lore.kernel.org/all/20220714071348.6792-1-johan+linaro@kernel.org/
> 
> The result of applying that series is that these structs are renamed
> after the IP revision (and sorted alphabetically) so the end-result is
> similar.
> 
> Could you consider dropping this patch, or at least the struct
> qcom_pcie_cfg bits, and applying the above series for 5.20?

I dropped it for now.  We can see how it shakes out after your series,
but not sure I'll get to it for this cycle.

Bjorn
