Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3888F7EF14C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 12:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345844AbjKQLAr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 06:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345820AbjKQLAq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 06:00:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B88C2;
        Fri, 17 Nov 2023 03:00:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA14EC433C8;
        Fri, 17 Nov 2023 11:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700218842;
        bh=UoF7Nr9aiLL6Qk9+QjG85dzn35c3D6g8QBytI8YPADI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jxl+z3VzPnLBZeIViaqu1FhM/werkN2mOFu08rv3pOAJsJyVdFXgBNTodjTs0TYOl
         jqgv9zVhJYR2O5fkAj46qgDLOomBp4baosr24oYttKXjc2NZ+pz1n3HU6DxoYTMVEg
         uu0lflv+4rO2s1sgm0w2VmOC0ynyutmeLDvPmtOfOEfyKPgmrWXw0SDD2NRcIsQxdq
         2v2HSaAQS29TvhEX+wcSmOjPY74Vy+4gqt/Xb3at3kLxJ5PjgJX+5Sr19UaH67uezF
         YpBMMZTdiQOtpZTOxrwzKStfiuhxNUdxdCPY9EcfWZ6iXbCZSosgm4aHfESyrlSCGy
         w0VgkAlC7Esqw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r3waa-0002Mj-2a;
        Fri, 17 Nov 2023 12:00:45 +0100
Date:   Fri, 17 Nov 2023 12:00:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
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
Message-ID: <ZVdH3GkzWupoxyzJ@hovoldconsulting.com>
References: <20231114135553.32301-1-johan+linaro@kernel.org>
 <20231114135553.32301-5-johan+linaro@kernel.org>
 <20231117103227.GM250770@thinkpad>
 <ZVdE6nqanqcaL8sO@hovoldconsulting.com>
 <20231117105404.GR250770@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117105404.GR250770@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 17, 2023 at 04:24:04PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 17, 2023 at 11:48:10AM +0100, Johan Hovold wrote:
> > On Fri, Nov 17, 2023 at 04:02:27PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Nov 14, 2023 at 02:55:51PM +0100, Johan Hovold wrote:
> > > > Break up the newly added ASPM comment so that it fits within the soft 80
> > > > character limit and becomes more readable.
> > > > 
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > 
> > > I think we discussed (80column soft limit for comments) in the past, but I don't
> > > think breaking here makes the comment more readable.
> > 
> > The coding style clearly states:
> > 
> > 	The preferred limit on the length of a single line is 80 columns.
> > 
> > 	Statements longer than 80 columns should be broken into sensible chunks,
> > 	unless exceeding 80 columns significantly increases readability and does
> > 	not hide information.
> > 
> > Going beyond 80 chars may sometimes be warranted for code, but the
> > exception is not intended for comments.
> 
> Breaking the comment here is indeed making it hard to read. It's just one word
> that needs to be broken if we go by 80 column limit and I won't prefer that,
> sorry!

Please read the above quote again, it is as clear as it gets. 80 chars
is the preferred limit unless (for code) exceeding it *significantly*
increases readability, which clearly isn't the case here (even if this
exception applied to comments).

I really don't understand why you keep insisting on this. Just fix your
editor.

Johan
