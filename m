Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B77D7B12FC
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 08:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjI1GcE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 02:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjI1Gbp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 02:31:45 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA481B1
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 23:31:39 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-578b4981526so7919211a12.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 23:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695882699; x=1696487499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CnNgEhksy6JyUenvntvdDf8qNAXSTU1fGqU1YXMs6HY=;
        b=p6JyfmZW/E9b9JbqL4n/LHekaMK96HWSHN03sBbyPbL7Ft9ezDwL9Ug19gOB+TQJRB
         KwJnHvBsAs1JGNQRgAVpvP10diFKM/PiKyg8d1vfUcEC/fwWhqgURFacyVih4GV1FL/7
         0l8dtQ2jZ0W3ZbwMgehh4Syw11Dq33lB3J6k22grU5f0166V7VK0UPBAM0NjKVOEOfrW
         rvFDkYWITkGLeqnYTzgw1SQHNGWm0u5Sy2UOv7MUWwrhVsSRDMFyhBWUUNaNGyMgPg8j
         e1XokMLG4SquJQSGU1NVNW5vLFqkFiRiqlt9S4PfUTGsggarA8kAlfpDpq8wAVRtX0jJ
         MNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695882699; x=1696487499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnNgEhksy6JyUenvntvdDf8qNAXSTU1fGqU1YXMs6HY=;
        b=eXi0+Okjo7n5gsjh8+r5zAmGQ9PgMqz2hxPY0FyuipgJc21YTIRFruLfNKuXbHJY1v
         bOYoNW1dCYQCE0HjwthXzxkTZnQuGkwn8uVRwA8QvmPwEXOK4n+vJfjWM9/fGPSn/c4I
         clxkovaOMeGXXr+8G914WZzz2zBxFjdV3Vpy0TTYLqI5h2dVmIDbXM3NnnlSw6OlCBnT
         Bz1efancBrWjD3Et2G05PbE7eU2Mac57IvWHC+teQLHSt6/p9qdPK7xY8HBkDkSIqaXf
         AMQVvbF46hXyxmrWuRLLBdRRi3OZOOSn+l/PMukxIxvPXc5eRVMVgbgR6geCFb1ihGWZ
         xWwg==
X-Gm-Message-State: AOJu0YxKTgb+oRbO+vDz/MAgM7iPnFPB/B4KcG7roMU93N0lx0gXETQ5
        dOLiuJdYTnTtXCFA4hCE1fapeQ==
X-Google-Smtp-Source: AGHT+IEJ7meKS5fzKsPZ6iXjhY0FikUwRdddU3+yeil6gcKA0lmFE1CtLXV39iamYXCS0rt+INPbqg==
X-Received: by 2002:a05:6a21:3288:b0:15e:986:d92b with SMTP id yt8-20020a056a21328800b0015e0986d92bmr406063pzb.16.1695882699233;
        Wed, 27 Sep 2023 23:31:39 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id iz7-20020a170902ef8700b001b9f7bc3e77sm4481817plb.189.2023.09.27.23.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 23:31:38 -0700 (PDT)
Date:   Thu, 28 Sep 2023 12:01:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
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
Message-ID: <20230928063136.3u47bw2lis6yvksn@vireshk-i7>
References: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
 <1694066433-8677-6-git-send-email-quic_krichai@quicinc.com>
 <20230927065324.w73ae326vs5ftlfo@vireshk-i7>
 <f7a5ac7f-2857-8d30-e29c-f64c2c5f1330@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a5ac7f-2857-8d30-e29c-f64c2c5f1330@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding everyone back, reply to you only by mistake earlier :(

On 28-09-23, 08:53, Krishna Chaitanya Chundru wrote:
> 
> On 9/27/2023 12:23 PM, Viresh Kumar wrote:
> > On 07-09-23, 11:30, Krishna chaitanya chundru wrote:
> > > While scaling the interconnect clocks based on PCIe link speed, it is also
> > > mandatory to scale the power domain performance state so that the SoC can
> > > run under optimum power conditions.
> > Why aren't you scaling interconnect bw via OPP core too ?
> 
> The power domain performance state varies from PCIe instance to instance and
> from target to target,
> 
> whereas interconnect BW remains same and changes only based upon PCIe GEN
> speed. So in the driver code itself
> 
> based upon GEN speed we are calculating the BW and voting for it.
> 
> That is the reason we are not scaling interconnect BW through OPP as no dt
> entries required for this.

Not sure I understand it fully yet. I tried looking at code and this is what I
see:

At probe initialization, you just configure bw.

Later on, towards end of probe and resume, you set both bw and performance
state.

Also your DT changes add virtual level numbers to PCIe OPP table like this:
+                               opp-1 {
+                                       opp-level = <1>;
+                                       required-opps = <&rpmhpd_opp_low_svs>;
+                               };

Instead what you can do here is, add bw values and remove level completely (as
it is not serving any meaningful purpose) and use the OPP core to set both bw
and performance state (via required OPPs).

What won't work if you do this ?

-- 
viresh
