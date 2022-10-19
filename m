Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D71060499F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 16:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJSOqy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 10:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJSOq0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 10:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0FF176B9D
        for <linux-pci@vger.kernel.org>; Wed, 19 Oct 2022 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666189967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5YibLNy+OciDPg1RqQtPWy91evf3zRYGT05L7hMD1SE=;
        b=K73TW2KwvaAFkVX7wQTDmg40Jp5EfQWvYH4WwD4eRfoy2QdDDcka2RWQHSqXydCXy02y1s
        YBIjGVUM2KD6gQdm9NRgpB3rC0EelT76puIlUAJyXbg5IS/TIO8vpOsC5QIWrtJ1jwuAV9
        6gGc3OAwPgIsZjbH79UTLx854PxSNd0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-175-8Elo9g_uMGGg7-OPkanmng-1; Wed, 19 Oct 2022 10:32:46 -0400
X-MC-Unique: 8Elo9g_uMGGg7-OPkanmng-1
Received: by mail-io1-f69.google.com with SMTP id s3-20020a5eaa03000000b006bbdfc81c6fso13358872ioe.4
        for <linux-pci@vger.kernel.org>; Wed, 19 Oct 2022 07:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YibLNy+OciDPg1RqQtPWy91evf3zRYGT05L7hMD1SE=;
        b=NsehgPHaw7uYfSVMmFVEaU+vBHgv8Sfp2ijLgWawo04RLxNhlRHE16RhzIh4V03Wnm
         BiWtlFKCuyDvGzsYsCvBa87KcVfTN5tP7WkdIWZiUMOa2fIGjhG0r6DBOJsnRhDZmDfg
         UNe6Ms7c/jNnAQNNXNpwag2wSZOORouY3O6LWTCVIPZXbTwCVfiHzjKhmNgD2Tkyr+tv
         e9MVJwjx4O6bw1VVDD2b+ZNt0eOwkP93A4absFyahmtfHZokN21unxzPvFs2NAgw5p3q
         q7MAD7zs5+GDDy9YDYJcZX9+JjZYZ4Aa8QikLyMKE+csFi9FHdWWxRyfwXrZM6ijls6F
         9Amg==
X-Gm-Message-State: ACrzQf19Ss7Ilhgm4qOXllIsHRWPrfUbGu1qzMAC5VpCeWS8/Is//P2N
        ZJvVxfYaJgjXL+pJQg/zLzpUON1BkC3JELssPV8Ho51qgsRqSYyqERxuvKvrHVTFZUCADwsb9eA
        u5tlNx1sAxheflA2bZj21
X-Received: by 2002:a02:54c1:0:b0:363:453e:2ccb with SMTP id t184-20020a0254c1000000b00363453e2ccbmr6451893jaa.228.1666189964202;
        Wed, 19 Oct 2022 07:32:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6/HkVuS6wNDB9egoiQiNu3qMpbMyAK3j1AnEKd9qXTPxLsvFR1yo6X9O/te7EZm3+VoF9IlA==
X-Received: by 2002:a02:54c1:0:b0:363:453e:2ccb with SMTP id t184-20020a0254c1000000b00363453e2ccbmr6451869jaa.228.1666189963941;
        Wed, 19 Oct 2022 07:32:43 -0700 (PDT)
Received: from x1 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id f20-20020a02a114000000b00363961f0f2dsm2140039jag.115.2022.10.19.07.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:32:43 -0700 (PDT)
Date:   Wed, 19 Oct 2022 10:32:41 -0400
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
Message-ID: <Y1AKiTkLa23idaf2@x1>
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
> +	/*
> +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> +	 * to be set before enabling interconnect clocks.
> +	 *
> +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> +	 * for the pcie-mem path.
> +	 */
> +	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));

[snip]

> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> +
> +	switch (speed) {
> +	case 1:
> +		bw = MBps_to_icc(250);
> +		break;
> +	case 2:
> +		bw = MBps_to_icc(500);
> +		break;
> +	default:
> +	case 3:
> +		bw = MBps_to_icc(985);
> +		break;
> +	}

Just curious: These platforms have a 4 lane PCIe bus. Why use 985
instead of 1000 for the maximum?

Brian

