Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CDE575102
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 16:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiGNOnL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 10:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbiGNOnG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 10:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C72AD3ED42
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 07:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657809784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eIdNk8O1gW+R+g6m9uiQ7NltrhT3ipP3bmVkK691BR8=;
        b=iJuMRWlCTqJ6TBk6ZUyE7C0zf+GfKkvwZMet8zFC11j+4sSuPCOSs8uQoIlhDvPbgNUSNm
        eWrY2krh1RhXHxJkR9v958HOxkMvY4nn2KvvjvRpQ1uZlJvTfvqAZ21taaEv1EtGHGZa2/
        u/KgAzrZwlfHYCKJjvVLaK3rpKhWmag=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-so8mzQJLMCaOXY_doCOINQ-1; Thu, 14 Jul 2022 10:42:56 -0400
X-MC-Unique: so8mzQJLMCaOXY_doCOINQ-1
Received: by mail-qt1-f197.google.com with SMTP id o22-20020ac87c56000000b0031d4ab81b21so1635607qtv.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 07:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eIdNk8O1gW+R+g6m9uiQ7NltrhT3ipP3bmVkK691BR8=;
        b=eZB7NZ6uMpTtL7DanBKZiqVPmncqWu6zZ/+GBcI3XQDAv2WScddbgaH6Sd5duQbnWM
         Kj9e0p1QiXSMxSJrVFrrtyYGKMaGiXGK1LttY7j05V9xnNQgzyKyqTv2ZZSzbDdtrs76
         63OBApNe0K+o2hzDQ1ELRoKDv+1xJbjzCkJBx2oMFg2QNkBHq5Hl09+qaVaunC6M1Cxs
         4oyndzOjtMfbHL8pw+I8b2qrPgZapl4mt/QwXqY/WvV6jxswF3KfC9Vjz8InokAlMTAQ
         BzOSRFRN92l5YIMciemRSdZTLIB4Ket9mmPKBIF1Jg7JlkjsI0NDik3P5qtdcxp4+MMo
         zQ4g==
X-Gm-Message-State: AJIora++e2lYN+rkh6Ek4ghHSfdzzls/0MXd7L3Sm6rxddk7pPhZqvoz
        6lOKXi+NOyOkbVzKf37xfvnCKx3v17/lGroBNOmcNZ75S9KQP9E98dOKIWgCcd12oRpzqXl+pDN
        2i1olNW75x3944fUsM8YY
X-Received: by 2002:a05:620a:e86:b0:6b5:4fc9:c0e5 with SMTP id w6-20020a05620a0e8600b006b54fc9c0e5mr6014482qkm.246.1657809776286;
        Thu, 14 Jul 2022 07:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u2p7lnj/YvP13oXDzpbzDj2LWU9ar42HAS8jRvmxUOpAd7BSRKi0iPqQbo+IpZSJ6Yqxpisw==
X-Received: by 2002:a05:620a:e86:b0:6b5:4fc9:c0e5 with SMTP id w6-20020a05620a0e8600b006b54fc9c0e5mr6014463qkm.246.1657809776056;
        Thu, 14 Jul 2022 07:42:56 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id e17-20020ac84911000000b0031eaabd2117sm1606432qtq.12.2022.07.14.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:42:55 -0700 (PDT)
Date:   Thu, 14 Jul 2022 10:42:54 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 7/8] PCI: qcom: Clean up IP configurations
Message-ID: <YtArbrYztI3FHZsb@xps13>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-8-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714071348.6792-8-johan+linaro@kernel.org>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 09:13:47AM +0200, Johan Hovold wrote:
> The various IP versions have different configurations that are encoded
> in separate sets of operation callbacks. Currently, there is no need for
> also maintaining corresponding sets of data parameters, but it is
> conceivable that these may again be found useful (e.g. to implement
> minor variations of the operation callbacks).
> 
> Rename the default configuration structures after the IP version they
> apply to so that they can more easily be reused by different SoCs.
> 
> Note that SoC specific configurations can be added later if need arises
> (e.g. cfg_sc8280xp).
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

