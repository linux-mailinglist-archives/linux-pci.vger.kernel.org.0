Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5759C7DF20A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 13:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjKBMJz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 08:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKBMJy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 08:09:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41760128;
        Thu,  2 Nov 2023 05:09:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A021FC433C7;
        Thu,  2 Nov 2023 12:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698926991;
        bh=IwE9+OvFRLx91Mib23swemUFGjVhO8KF9WcxPps/jzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SRW8Tc5FZ8RxUVh+wdGHrbvjyKFIYpnUUNw2ZsH8qdEMiE0mEzoRZRaybRTTlYzDA
         NlxH7vHPtKL0xnIFxITJPqC6pr4xMU7oFmTKcYVPm5Ze2CJf+qsbXtCyhhBgEvh00w
         TUIsqio11IPhFjZK4IKJ6HTN2oFsZXKCxhHeRePwL2yuhU04m7c4LRsJL80RW1ETam
         nT5l44sn4SnYmLPAT1/n9uVMPjd9ysMXaCtTS1NefKIW6AM40widFo4v2IC61Ui63R
         PRm503pvXhyS2XsGk485oiiaq6n1PIo3xjnFWSZ4DiJFQb15aChjHPFh1Ie+6HXYzC
         AQvxUrpbeF2Rw==
Date:   Thu, 2 Nov 2023 07:09:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v5 5/5] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20231102120950.GA115288@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102053013.7yt7pxin5awlu7w7@vireshk-i7>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 02, 2023 at 11:00:13AM +0530, Viresh Kumar wrote:
> On 01-11-23, 17:17, Bjorn Helgaas wrote:
> > Can you expand "OPP" somewhere so we know what it stands for?  I'm
> > sure everybody knows except me :)
> 
> It is "Operating Performance Points", defined here:
> 
> Documentation/power/opp.rst

Thanks; I meant in the subject or commit log of the next revision, of
course.
