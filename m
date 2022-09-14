Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E753E5B8963
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 15:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiINNp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 09:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiINNp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 09:45:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394AA5924B;
        Wed, 14 Sep 2022 06:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF1D0B81B67;
        Wed, 14 Sep 2022 13:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7332C433B5;
        Wed, 14 Sep 2022 13:45:44 +0000 (UTC)
Date:   Wed, 14 Sep 2022 19:15:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, bhelgaas@google.com, treding@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <20220914134539.GI16459@workstation>
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas>
 <20220914062411.GD16459@workstation>
 <29b39edd-10ab-b679-f270-67b0b406ca2f@nvidia.com>
 <20220914111857.GF16459@workstation>
 <5ffe3dfa-28a5-a5fc-0ae2-28927c39dc03@nvidia.com>
 <20220914114306.GG16459@workstation>
 <YyHMvBhWgbDtv6V2@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyHMvBhWgbDtv6V2@rocinante>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 14, 2022 at 09:44:44PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > Anyway, I don't strongly object the change and leave it to the
> > maintainers to decide.
> 
> Perhaps it makes sense to make this a dev_dbg() over dev_info(), especially
> since it appears that this information is of more use to the developer (who
> most likely has the suitable log level set anyway), and given that there is
> no way to reliably detect a presence in a slot on some platforms, this
> might otherwise, add to the other messages that normal users don't pay
> attention to usually - if this is not to be treated as an error.
> 

No, this is clearly not a debug message. As I quoted above, the link up
can fail due to an issue with PHY also. In that case, user has to see
the log to debug/report the issue.

So, either dev_info() or dev_err().

Thanks,
Mani

> 	Krzysztof
