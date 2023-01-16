Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275F766BCD3
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 12:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjAPLZv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 06:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjAPLZu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 06:25:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C4C1DB99;
        Mon, 16 Jan 2023 03:25:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FD8960F66;
        Mon, 16 Jan 2023 11:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A41C433EF;
        Mon, 16 Jan 2023 11:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673868349;
        bh=FUq7UxCOUiutH7Be3J196rTcDsnh/wAPIdZu/jyQFlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlcEBQYchwvOmx+MeC5SiZOECRn3YfUcH8dCIqscrTnlrazVR7tghY+Vb2IJwPJQb
         ivsfpfD3vdmwE1CYmFYLng7Fq9ge+Rejfo2s1Q0CBjL8+LQhWpcQm3r51BAUZ1TjNd
         +bGv/Vk9E1WzPNCF8U0TkXbYAmm+uUnbIvlQoXBoVWRnZPYTgLN28qK24AIhuPN0u2
         UDJQIkvgDH0uO0D6wZkuU6A8NEtLnX1J1LjoY4JXce8k+IDiQSeDc9RwLHIIiu+2MV
         xAxyMjL+ixGIj3OtR7Wbtz8WAoJoCdtg3Nun5R6rCj23GRNeXxHFX8rbVWt2D86bUj
         o96JERSrnLOWw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pHNct-0003hX-5m; Mon, 16 Jan 2023 12:26:07 +0100
Date:   Mon, 16 Jan 2023 12:26:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: qcom: Use clk_bulk_ API for 1.0.0 clocks
 handling
Message-ID: <Y8U0T4YVUhe/4hRv@hovoldconsulting.com>
References: <20221020103120.1541862-1-dmitry.baryshkov@linaro.org>
 <20221020103120.1541862-3-dmitry.baryshkov@linaro.org>
 <Y1EsOGhEqNe9Cxo6@hovoldconsulting.com>
 <30850757-0e39-bd3d-0d4f-cdb4627b097c@linaro.org>
 <Y8F+sSf3yG1mLhJo@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8F+sSf3yG1mLhJo@lpieralisi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023 at 04:54:25PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Oct 20, 2022 at 02:22:47PM +0300, Dmitry Baryshkov wrote:
> > On 20/10/2022 14:08, Johan Hovold wrote:
> > > On Thu, Oct 20, 2022 at 01:31:18PM +0300, Dmitry Baryshkov wrote:
> > > > Change hand-coded implementation of bulk clocks to use the existing
> > > 
> > > Let's hope everything is "hand-coded" at least for a few years still
> > > (job security). ;)
> > > 
> > > Perhaps rephrase using "open-coded"?
> > 
> > Yes, thank you.
> 
> If that's the only change required I can fix it up when merging the
> series.

I believe there was also a couple of bugs in patch 3/4 which was spotted
by Jingoo Han and that would need to be fixed:

	https://lore.kernel.org/all/CAPOBaE5Zg+r0F35MvKWAozFa9x4xvym1LbA_UHvUSmnLbTpqzA@mail.gmail.com/

Johan
