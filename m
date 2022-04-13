Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BDB4FF00F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 08:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiDMGrb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 02:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiDMGrb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 02:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C76362FC;
        Tue, 12 Apr 2022 23:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C1C461D26;
        Wed, 13 Apr 2022 06:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9FEC385A3;
        Wed, 13 Apr 2022 06:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649832306;
        bh=r2vW3ZbHso9uGN1E9szsNGXBN90bOBs2BYM7Wg9/Kng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oG2beXM740vxSU2IPV+mku2PjnBvJPvVqKyXuUXoCiEmPAYxA7EMCHKd09m1LVyz+
         2QT0QDL5NAApHR+hRBJFcIrd+++CnbdyHoZckTtM2wY6D3VWMXGkYRg3zLP337P0rO
         C9zv7j0uCmoSnwx5KDmfgpDic4HVRJZ4e8UORwsf/k1WaWHkTfh9IM+twvyW/izMwF
         Iv0H0d36WzRPZ5jsePA2vY5o5hprUGuh/jcqv5WDh+l5LcqkRhH6G2oRfI/OP3tXxZ
         ex2Qqd5i0WbRRCZL4pMg2VIXSwPfSYwYQrYCZujxkz0zrnSWpYv1xEdA2JWu/6VBpv
         jSj8pbdep6ePQ==
Date:   Wed, 13 Apr 2022 12:15:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     wangseok.lee@samsung.com,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        =?utf-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
Subject: Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
Message-ID: <YlZxbXI77vSbKNsY@matsya>
References: <564c7092-d6a3-7766-d83f-9762075d055f@kernel.org>
 <0716d9e4-24e1-d16c-162c-00a8664296e1@kernel.org>
 <20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p7>
 <20220328090200epcms2p8637d2a2e09a3a627be776586b80c8adf@epcms2p8>
 <CGME20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p4>
 <20220328112918epcms2p44bfdd6ef74c14f04bae6a475054860b6@epcms2p4>
 <fd3478ba-ebb9-c1bf-1823-dc03de80b76e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd3478ba-ebb9-c1bf-1823-dc03de80b76e@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28-03-22, 13:40, Krzysztof Kozlowski wrote:
> On 28/03/2022 13:29, 이왕석 wrote:
> >> --------- Original Message ---------
> >> Sender : Krzysztof Kozlowski <krzk@kernel.org>
> >> Date : 2022-03-28 18:38 (GMT+9)
> >> Title : Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
> >>
> >> On 28/03/2022 11:02, 이왕석 wrote:
> >>>>  --------- Original Message ---------
> >>>>  Sender : Krzysztof Kozlowski <krzk@kernel.org>
> >>>>  Date : 2022-03-28 16:12 (GMT+9)
> >>>>  Title : Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
> >>>>
> >>>>  On 28/03/2022 03:44, 이왕석 wrote:
> >>>>>   This series patches include newly PCIe support for Axis ARTPEC-8 SoC.
> >>>>>   ARTPEC-8 is the SoC platform of Axis Communications.
> >>>>>   PCIe controller driver and phy driver have been newly added.
> >>>>>   There is also a new MAINTAINER in the addition of phy driver.
> >>>>>   PCIe controller is designed based on Design-Ware PCIe controller IP
> >>>>>   and PCIe phy is desinged based on SAMSUNG PHY IP.
> >>>>>   It also includes modifications to the Design-Ware controller driver to 
> >>>>>   run the 64bit-based ARTPEC-8 PCIe controller driver.
> >>>>>   It consists of 6 patches in total.
> >>>>>   
> >>>>>   This series has been tested on AXIS SW bring-up board 
> >>>>>   with ARTPEC-8 chipset.
> >>>>
> >>>>  You lost mail threading. This makes reading this difficult for us. Plus
> >>>>  you sent something non-applicable (patch #2), so please resend.
> >>>>
> >>>>  Knowing recent Samsung reluctance to extend existing drivers and always
> >>>>  duplicate, please provide description/analysis why this driver cannot be
> >>>>  combined with existing driver. The answer like: we need several syscon
> >>>>  because we do not implement other frameworks (like interconnect) are not
> >>>>  valid.
> >>>>
> >>>>  Best regards,
> >>>>  Krzysztof
> >>>  
> >>>  Hello, Krzysztof
> >>>  Thanks for your review.
> >>>  
> >>>  patch#2 was sent to the wrong format so sent again.
> >>>  Sorry for causing confusion.
> >>  
> >> The first sending was HTML. Second was broken text, so still not working.
> >>
> >> Please resend everything with proper threading.
> > 
> > Hello, Krzysztof
> > 
> > I sent patch#2 three times.
> > due to the influence of the email system,
> > there was something wrong with the first and second mails.
> > Sorry for causing confusion.
> > Did you receive the third patch i sent you?
> 
> Maybe, I don't know. It's not threaded so it's difficult to find it
> among other 100 emails...

Correct, this is spread over whole list, please resend the whole series
in a single shot without threading being broken

-- 
~Vinod
