Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8F5E9A38
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 09:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiIZHK2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 03:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiIZHKB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 03:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690BD2716E;
        Mon, 26 Sep 2022 00:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59E1860F5D;
        Mon, 26 Sep 2022 07:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F62C433D6;
        Mon, 26 Sep 2022 07:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664176152;
        bh=ZFyz9xsgaJJeQ1kuNUppXbSdEwEfhTR8PAQww7gBoFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afl5wolvQgakUNRD6b9wDaE0fxMFJlHlLLP9m1EckmAbmq5dhsA/vn6LO/BOkjL4S
         DPJ7DqhR8zmyVsCr0WBzUq/bBI6xzqbtocN0cy9VLG1jvrZFsuuKTP+pFlLqsrgSZ5
         kKG7S40CkE62+B7zCN1uEOigV/173ZjYpN8RjviYjn/cyAVpAZZvUhmbBaoO4kQAm3
         OVGB3iJ9eJcNTcxFFS8OGKseOAP/o1cz0OdRUi8mw5z4AiR0a9l1EIv+YGtLhFOAYs
         vfxx7Z5v3jjMHiNoQ3s9ReMupn5KmPLkw3T/AeLHJuxjOhjtBM4qUdd0wDkEH8FHzT
         RMOC+WCdz1SMQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ociEv-0003Yx-AN; Mon, 26 Sep 2022 09:09:18 +0200
Date:   Mon, 26 Sep 2022 09:09:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
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
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 0/9] PCI: qcom: Support using the same PHY for both RC
 and EP
Message-ID: <YzFQHa/JUflySPIl@hovoldconsulting.com>
References: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
 <YyF5SJASdCJWcPaX@hovoldconsulting.com>
 <Yy6aHB6qc/pHEZi2@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy6aHB6qc/pHEZi2@matsya>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 24, 2022 at 11:18:12AM +0530, Vinod Koul wrote:
> On 14-09-22, 08:48, Johan Hovold wrote:
> > On Fri, Sep 09, 2022 at 12:14:24PM +0300, Dmitry Baryshkov wrote:
> 
> > > Changes since v2:
> > > - Added PHY_SUBMODE_PCIE_RC/EP defines (Vinod),
> > > - Changed `primary' table name to `main', added extra comments
> > >   describing that `secondary' are the additional tables, not required in
> > >   most of the cases (following the suggestion by Johan to rename
> > >   `primary' table),
> > 
> > This wasn't really what I suggested. "main" is in itself is no more
> > understandable than "primary".
> > 
> > Please take another look at:
> > 
> > 	https://lore.kernel.org/all/Yw2+aVbqBfMSUcWq@hovoldconsulting.com/
> 
> Am not sure example quoted there was very initutive:
> "as the tables can be referred to as
> 
> 	cfg.tbls2.serdes
> 
> instead of
> 	
> 	cfg.secondary.serdes_tbl;"

The main point was that "secondary" doesn't say anything about what the
variable is used for (unlike for example "secondary_tbls") and that
keeping a "_tbl" suffix on every member in a structure that holds only
tables is redundant.

> I would agree with Johan that primary and secondary are too long, but
> that tbls2 is not very intuitive either...

That could be

	cfg.tbls_extra.serdes;

too or whatever. The key point was to have a descriptive name of the
tables-structure variable and dropping "_tbl" from the individual
members.

Johan
