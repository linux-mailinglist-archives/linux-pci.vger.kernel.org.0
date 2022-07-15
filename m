Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B055575E7C
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiGOJ0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 05:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGOJ0b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 05:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C18E7A519
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 02:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657877189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cyx4Y/rgs0Wa/WcmYfTIRodZYO11O2cxtE3O0yBB4l4=;
        b=GmnZcBgGpr1O1Nk+NCcVptj1YAcPsS5ttaOkz3hDRIS7m8fZ8VddGirY2VkjhkZbACBpu6
        L8MT3i88uqlOuWEN1q6FehVmjjuuJRLcuN8IacC+fIkc3/2g9z6HhekR6zUFpfSOWMiGCg
        EYMlI8BfHS5fJ/e+1mK/xV3wDmC0KF4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-NhAfv62VPlSfQoPtFG2ckg-1; Fri, 15 Jul 2022 05:26:28 -0400
X-MC-Unique: NhAfv62VPlSfQoPtFG2ckg-1
Received: by mail-qt1-f200.google.com with SMTP id r5-20020ac85c85000000b0031ecf611c64so3317731qta.23
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 02:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cyx4Y/rgs0Wa/WcmYfTIRodZYO11O2cxtE3O0yBB4l4=;
        b=IT2o5D2XCslbtEAVs02I77B4QXy8Is8JXK0sZe0/MgfKL5CIoLJRm7UNkOWYu1Oc/j
         ugolEYk2MlA+AWMsQgf8dBRUSWxh80EW1BiUbUsA249Bx9ggOcWa9Ht5cYiiTOokPaPB
         uAvegzpXeNGRQFpRmUh4sktxIzuZV54o990Ls5JPD3lINo8GP7p/LLxaZE9EU3vYwvvZ
         2I1vEoAxYGK5hCnqExTezStVSkcZXyYKeeuEYgfu54U+Qq8nrn30o63mGmSa7CIhZTQu
         MgAqk14qtgoBFdZ6mp28i9Rh2zZiISJuH2thLczhoQ9ivMYJ2euIn6MkSUKD/vPnLCAq
         7ylA==
X-Gm-Message-State: AJIora//2OgAOvRZ2P7sTfGzXYs/LOoDsi9FpQHclTjnM3lSzbS+DAW/
        W3qjTjxPMGTwkzH0mGjhTAtzrjaiuk2KEda+pGWMDPWeBeAB3D9Rjc6XW0eJcrs/4fw8/QeAVDd
        3V1hFRSYIjGEzwt0Js9cg
X-Received: by 2002:a05:620a:462a:b0:6b2:585c:16a6 with SMTP id br42-20020a05620a462a00b006b2585c16a6mr8850432qkb.631.1657877187933;
        Fri, 15 Jul 2022 02:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tb4kWhRfH7kMvJFXklN2hfIO1eVHUU+Mc1AZkI9TMXlrcPA8c3fAm5ySZDU+7KYvH9uBXnOw==
X-Received: by 2002:a05:620a:462a:b0:6b2:585c:16a6 with SMTP id br42-20020a05620a462a00b006b2585c16a6mr8850422qkb.631.1657877187731;
        Fri, 15 Jul 2022 02:26:27 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id g14-20020a05620a40ce00b006af3bc9c6bbsm4297202qko.52.2022.07.15.02.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 02:26:27 -0700 (PDT)
Date:   Fri, 15 Jul 2022 05:26:26 -0400
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] PCI: qcom: Sort device-id table
Message-ID: <YtEywsPAvJGQLAUu@xps13>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-9-johan+linaro@kernel.org>
 <YtAny03L/RLk9nv6@xps13>
 <YtEaqHT7NdXPhK+y@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtEaqHT7NdXPhK+y@hovoldconsulting.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 09:43:36AM +0200, Johan Hovold wrote:
> If we only had some sort of machine that could sort strings for us... ;)
> I'll rely on vim for this from now on.
> 
> Perhaps Bjorn H can fix that up when applying unless I'll be sending a
> v3 for some other reason. This series still depends on the MSI rework to
> be applied first.
> 
> Thanks for reviewing.

OK, sounds good... once it's fixed, my R-b can be added:

Reviewed-by: Brian Masney <bmasney@redhat.com>

