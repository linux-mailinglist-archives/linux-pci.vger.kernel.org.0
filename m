Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808FE525D34
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 10:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377952AbiEMIUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 04:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351157AbiEMIUK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 04:20:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B9D261FB8;
        Fri, 13 May 2022 01:19:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7A536202A;
        Fri, 13 May 2022 08:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D663C34118;
        Fri, 13 May 2022 08:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652429988;
        bh=+yihzS0RWWyeTIkEeVH6oYRX3g8QB8DyI5BsLFSGHX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VifpVXwKTTPFlSLrdi0cs0RtX/PY/QpEGdq/enPD+31PGDssssHrGhIFkjcqEPDOn
         QNvZnGwoU6kUDG3zHL8BwT27uF6ViPY8TlR1/bpFMAjyCWSENB0j4vF8citfNeu9XE
         GlTX9Nz3VTtMHvFEL+hioLK+9X0VXRCzmsdFSQBBuN3FHNGMNVZKM/ozcOGV6lrk1U
         LeM5BHFhmzGCJaltfYhACMNyF9/Mex2sZchVFcPc0gzKf9O9ALhnHL6jCFUVK8wzmk
         EThtSUvM8eRSGrD9Ovj7rMHhdnlHVPx/sPf08AL3qE47BYKOguKlvYGnhoGs1GOzb5
         8E8DtQkOsybfA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npQWW-0007Cp-Kh; Fri, 13 May 2022 10:19:44 +0200
Date:   Fri, 13 May 2022 10:19:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>
Subject: Re: [PATCH v5 5/5] PCI: qcom: Drop manual pipe_clk_src handling
Message-ID: <Yn4UoE7NKTURYtI+@hovoldconsulting.com>
References: <20220512172909.2436302-1-dmitry.baryshkov@linaro.org>
 <20220512172909.2436302-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512172909.2436302-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 08:29:09PM +0300, Dmitry Baryshkov wrote:
> Manual reparenting of pipe_clk_src is being replaced with the parking of
> the clock with clk_disable()/clk_enable(). Drop redundant code letting
> the pipe clock driver park the clock to the safe bi_tcxo parent
> automatically.

You ignored my comments on this one too.

Johan
