Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC2F5750CD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 16:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiGNO3v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 10:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbiGNO3u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 10:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78E5A5C377
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657808988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8oBD289dGEOPLHJiPefuD87Ky4LKaAMPVE1HnT2THU=;
        b=iClZfEDVgDNQghCEk4+SnhMQIcBbKbDL2Z+MxiEBtgAgVbHQOHFHTmfeXPBmFjVWZHIFuQ
        qPwHoJ3OFx7CKTOW1acjtsyXbsJUhptCnByGmd6xp1szTboRq6IjF42NBqclU65CWyS/jV
        ffJiT+xRn23Ml10HLk4lIcZed438paQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-53NgrR3TMjWH7ubTGxfjSA-1; Thu, 14 Jul 2022 10:29:46 -0400
X-MC-Unique: 53NgrR3TMjWH7ubTGxfjSA-1
Received: by mail-qk1-f198.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso265209qkp.21
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 07:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N8oBD289dGEOPLHJiPefuD87Ky4LKaAMPVE1HnT2THU=;
        b=kXlUZwVrM79en9hv8rexhCD7HrzkpK4Iv18N/XGRawQnE1hZE9zvegIW9omdzmgaUn
         Is0V72z7QiaLkGMh0SvxaxrOmPn1tJd9b+Nu4HQ+0P0XhQlCXVA7Kmpa6z32L3dmeATa
         JgL7085uTSzxfgqVl5pYXAF71DRJDps/E2dU9hc4ojuHQus12DM8rTlx4dd8sjnRWrjo
         nQBx8ZTD7CCj6Sk6pflevAHxr8ueKM07cS01rSnpT5mR0f3tOc/8SrRTk7WH+jX5VD9t
         ljRKo9gh98HHyJxOEklsrzNKl98V1lWLTlCDQQDlWjQOxSxTcmIpLdxdn2tOShL/1q/p
         7cJQ==
X-Gm-Message-State: AJIora/vuEDKpVFQDdPPRK+vNtQf/j2y6Ncg5rbY1P8SAsppRNeVS8fx
        vx6dCR+C2KTg9pNqgNy+ojUvkwZX0E05fe+uSxzRh/Pk3m9ubS1wYqOgc/9izZDO6kySI3sU52b
        GVWL4DlFW1b20+9WKnhRm
X-Received: by 2002:a05:620a:490b:b0:6b5:50ba:df51 with SMTP id ed11-20020a05620a490b00b006b550badf51mr6154039qkb.53.1657808986446;
        Thu, 14 Jul 2022 07:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t16Q/9bg8jc78Kiv5IS34JX5fMV5xULfn6e6fF+bl1rBRgdTiM9zrPFe4bMltLNPjW6XLFWQ==
X-Received: by 2002:a05:620a:490b:b0:6b5:50ba:df51 with SMTP id ed11-20020a05620a490b00b006b550badf51mr6154013qkb.53.1657808986204;
        Thu, 14 Jul 2022 07:29:46 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id v11-20020a05622a014b00b0031e99798d70sm1719199qtw.29.2022.07.14.07.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:29:45 -0700 (PDT)
Date:   Thu, 14 Jul 2022 10:29:44 -0400
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 3/8] dt-bindings: PCI: qcom: Add SA8540P to binding
Message-ID: <YtAoWOngodHMLY9L@xps13>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-4-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714071348.6792-4-johan+linaro@kernel.org>
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

On Thu, Jul 14, 2022 at 09:13:43AM +0200, Johan Hovold wrote:
> SA8540P is a new platform related to SC8280XP but which uses a single
> host interrupt for MSI routing.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

