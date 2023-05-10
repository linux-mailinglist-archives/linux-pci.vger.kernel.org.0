Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B486E6FE55E
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 22:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjEJUsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 16:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjEJUsC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 16:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100C10FA;
        Wed, 10 May 2023 13:48:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DCFC64043;
        Wed, 10 May 2023 20:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B46C433D2;
        Wed, 10 May 2023 20:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683751680;
        bh=p1v9BgVQxNA6CFzcqYCk9q5zJL82xRDoaqm5OkM6CLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jWrc2Fp4/sCVBp6UHKhYlkrY8SgsyIV1wgvS1fT/r2/D0jxYgQ0LsGjy8CTO+dRSV
         MeUtgW5MbckP8PH4JKRXRc2HjkiksoEE+2fvebpIt2/1WRl8MWeoLKYXwK2XbGJ8eq
         h3Vd9/7EDn8otCnP42jgnCokGb7J0bGy4j4y7UzVVQliiTs67fxCcRGNhGh/BNxwuv
         jj7lz8nAhxCjQ7EwG34CFIavsuOrEysWMXjda8d/QAscgTcZ7z6olL/VpTZgyK8CNG
         oMqpOAQC2uHVa5owxMaThE5Yj2W2Ph8LeLMN4Ksy4njspZ996Tb4XTOdzB6x2YbGQ+
         1jzhTYmToHSdA==
Date:   Wed, 10 May 2023 15:47:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        linux-pci@vger.kernel.org, robh@kernel.org, heiko@sntech.de,
        kw@linux.com, shawn.lin@rock-chips.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        linux-rockchip@lists.infradead.org, broonie@kernel.org,
        bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lpieralisi@kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Johansen <strit@manjaro.org>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
Message-ID: <ZFwC/seTfSoaLn0v@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdYzYp6=mYSoUHN3TEXVSMbRt1HpRm0X_4RMez09V0XzQewaw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 09, 2023 at 08:11:29PM -0400, Peter Geis wrote:
> On Tue, May 9, 2023 at 5:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, May 09, 2023 at 05:39:12PM +0200, Vincenzo Palazzo wrote:
> > > Add a configurable delay to the Rockchip PCIe driver to address
> > > crashes that occur on some old devices, such as the Pine64 RockPro64.
> > >
> > > This issue is affecting the ARM community, but there is no
> > > upstream solution for it yet.
> >
> > It sounds like this happens with several endpoints, right?  And I
> > assume the endpoints work fine in other non-Rockchip systems?  If
> > that's the case, my guess is the problem is with the Rockchip host
> > controller and how it's initialized, not with the endpoints.
> > ...

> The main issue with the rk3399 is the PCIe controller is buggy and
> triggers a SoC panic when certain error conditions occur that should
> be handled gracefully. One of those conditions is when an endpoint
> requests an access to wait and retry later.

I assume this refers to a Completion with Request Retry Status (RRS)?

> Many years ago we ran that issue to ground and with Robin Murphy's
> help we found that while it's possible to gracefully handle that
> condition it required hijacking the entire arm64 error handling
> routine. Not exactly scalable for just one SoC.

Do you have a pointer to that discussion?  The URL might save
repeating the whole exercise and could be useful for the commit log
when we try to resolve this.

> The configurable waits allow us to program reasonable times for
> 90% of the endpoints that come up in the normal amount of time, while
> being able to adjust it for the other 10% that do not. Some require
> multiple seconds before they return without error. Part of the reason
> we don't want to hardcode the wait time is because the probe isn't
> handled asynchronously, so the kernel appears to hang while waiting
> for the timeout.

Is there some way for users to figure out that they would need this
property?  Or is it just "if your kernel panics on boot, try
adding or increasing "bus-scan-delay-ms" in your DT?

Bjorn
