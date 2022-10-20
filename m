Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECA4606639
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 18:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJTQuG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 12:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJTQuE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 12:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9D75FDDF
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666284599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uoGto+gNH92mAm1Kdu+EjWKJigMkRDwEWaF/cwWxdwc=;
        b=gz0vE6dkAS3kpRinzADQ8yzgu5Jjk3yD7qfY/xIwTwfKgLxdw7D+U7BEbBimaUFXRBqkUY
        FZPFO+s46CgFODiBIhCHHy0yINGCxIa03k6tUH8i4U6oPeZg/C7Vy3UWrpeiuJIw60EhUH
        apnL+ZZQ2QS5PH9L9OJigM5/7uuRNaE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-424-G9HE6b-SMlm-xNKF7p-CLA-1; Thu, 20 Oct 2022 12:49:58 -0400
X-MC-Unique: G9HE6b-SMlm-xNKF7p-CLA-1
Received: by mail-io1-f70.google.com with SMTP id s3-20020a5eaa03000000b006bbdfc81c6fso55579ioe.4
        for <linux-pci@vger.kernel.org>; Thu, 20 Oct 2022 09:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoGto+gNH92mAm1Kdu+EjWKJigMkRDwEWaF/cwWxdwc=;
        b=q3plzOlR+RCkORb/BJvqHIC9kpi0nIaeTCp8Gq+CTBP/to/2Qr01h6dtq+7aaklNEb
         e8cFUuk/Dl+I/1J+RkvdcjQcx1LZTotdZbiqYSnUrG5rSiTAv0dwSWsJjzZVLBNEGWcu
         eoefam4j9BxC/TDAKqn6Yeh5mqkbemSHaFKMcQQHqT7ghQSFFpishW49J1U+uQqS02Nh
         8tN7Uh/VGUPA3asutpoXGD/04byOsnBDmYDuEZCmApPxRvMVzL/J20tXnvyCt6wXuKVB
         2jQIhqNVcs1qhFPNawVB9WRX5u30Efozfq2MYMHJb9e0RvqB3f+bM20nS7sYXqteR+Bm
         cqvw==
X-Gm-Message-State: ACrzQf0jmAcxuHQMxHF3qLCESBb/MWv2ziifthfHHwAAoWQMo+qAPaZw
        z92zmocH0HrR4gV7vVJNtUSk8gXsE4Y0mFBoJz2MnyiFzii+biY2zMujaJ0coOk7JDFKeRqcf62
        SUpWSYQ7caR9Wg7UNepXu
X-Received: by 2002:a05:6638:4987:b0:363:c403:28ff with SMTP id cv7-20020a056638498700b00363c40328ffmr10097980jab.235.1666284597637;
        Thu, 20 Oct 2022 09:49:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5f69+U/H3YHmxW+EIukcVAqLTXZEmABQS3o/TzzGrb3p1R4FOeCnxcVZxE631gJUxtqBzN1Q==
X-Received: by 2002:a05:6638:4987:b0:363:c403:28ff with SMTP id cv7-20020a056638498700b00363c40328ffmr10097946jab.235.1666284597136;
        Thu, 20 Oct 2022 09:49:57 -0700 (PDT)
Received: from x1 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id y19-20020a056602121300b006bb5af55ddfsm3477224iot.19.2022.10.20.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:49:56 -0700 (PDT)
Date:   Thu, 20 Oct 2022 12:49:54 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: qcom: Add basic interconnect support
Message-ID: <Y1F8MqeHxj5IaLtx@x1>
References: <20221017112449.2146-1-johan+linaro@kernel.org>
 <20221017112449.2146-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017112449.2146-3-johan+linaro@kernel.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 17, 2022 at 01:24:49PM +0200, Johan Hovold wrote:
> On Qualcomm platforms like SC8280XP and SA8540P interconnect bandwidth
> must be requested before enabling interconnect clocks.
> 
> Add basic support for managing an optional "pcie-mem" interconnect path
> by setting a low constraint before enabling clocks and updating it after
> the link is up.
> 
> Note that it is not possible for a controller driver to set anything but
> a maximum peak bandwidth as expected average bandwidth will vary with
> use case and actual use (and power policy?). This very much remains an
> unresolved problem with the interconnect framework.
> 
> Also note that no constraint is set for the SC8280XP/SA8540P "cpu-pcie"
> path for now as it is not clear what an appropriate constraint would be
> (and the system does not crash when left unspecified currently).
> 
> Fixes: 70574511f3fc ("PCI: qcom: Add support for SC8280XP")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

