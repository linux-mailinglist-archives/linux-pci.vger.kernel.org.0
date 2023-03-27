Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE866CA6D1
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 16:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjC0OKB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 10:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjC0OKA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 10:10:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9487BD3;
        Mon, 27 Mar 2023 07:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59A90B80BEC;
        Mon, 27 Mar 2023 14:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE99C433EF;
        Mon, 27 Mar 2023 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679926196;
        bh=qhleqvSXG55LxvL+uEa9mQ1uZqawiIM0nEiCIToDFzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyz3rDhZiVPqbbQYupLmUGWcI1BIvh3RYJcqWZuuFKl3ygJh3GXR3R1M9hWXUv9qY
         rdl/JEvArv34V2ryq0xWC7VFi2Z3tvIwOrl6AErokW4MQfmapOtZ3hQ6AM+GvSZx0z
         G/PEzJtXUyXAZJa8Fblso8ugrxIukM4NSndWNi7gCmlzGLqTnz3BUppmnsu5GvbMvJ
         WGA6Re0e5drIsKBQnbX5Ve737LcMqu3SjUOakQ9F402KcbNBT5mTXTPk49dBbziPOJ
         wuqFaaOUl+6yvAjkgskdkzv/Q8MhoD1XQ5NXjOpio67D6supKhRshqwW9nMMBUEtlg
         EjtXMFKw+HRjQ==
Date:   Mon, 27 Mar 2023 07:12:59 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 00/12] Introduce the SC8180x devices
Message-ID: <20230327141259.bjdtyvhilxuxts62@ripper>
References: <20230325122444.249507-1-vkoul@kernel.org>
 <6f6be544-48da-0c22-ea54-e07e35131ec9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f6be544-48da-0c22-ea54-e07e35131ec9@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 27, 2023 at 09:46:31AM +0200, Krzysztof Kozlowski wrote:
> On 25/03/2023 13:24, Vinod Koul wrote:
> > This introduces Qualcomm SC8180x SoC which features in Lenovo Flex 5G
> > laptop. This also adds support for Primus platform as well as Lenovo Flex 5G
> > laptop.
> > 
> > I would be great if submaintainers can ack the binding patch so that
> > everything can go thru qcom tree
> 
> I think Bjorn recently was rejecting taking bindings patches, so what
> changed?
> 

Nothing changed. In the interest of reducing the risk for merge
conflicts I still think it's best if bindings goes via respective
maintainer trees; so patch 1 is for me...

Regards,
Bjorn
