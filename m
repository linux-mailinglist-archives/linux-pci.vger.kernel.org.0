Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A5C562E8F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 10:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiGAIlU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 04:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbiGAIlR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 04:41:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540A671271;
        Fri,  1 Jul 2022 01:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF837B82F0E;
        Fri,  1 Jul 2022 08:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E988C341C6;
        Fri,  1 Jul 2022 08:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656664871;
        bh=uKnZtXtyLVTiUaQqzsGKQbY0Solxh41fc97vwgyaR+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JHDw8hPqw9QAu61um9xt3oZE/rMgGEPfF9CRxiCtyshMA+I1BCulyN6Y5LN86RHqf
         SSXXmM6YnmxmHbDOYVSZ2L8DJjp4hWI5fpmWJFvN4XihHqfqJVTS+IyWTZotrgjAFe
         JTPjBXIRw3tV4KOw7JmlyHDURBg2gFlR1vzrbdkY2Bz+uvbGP5rJVpv/C0vn5MlOYv
         uAxNWJjJzb537dnxplKKQXwcGbbs8IAQNvpGJPepzDpDW9UbXg712mz1/s4jmW7HXe
         Eu2X0/EUr5fKoJa8ScL99xAhpQ/KeQyqWFFlN6NhvHgkG1SA1VkdlcHe4nUQFuvoSQ
         SLqslm2/YmFJA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o7CD9-0001Y4-2X; Fri, 01 Jul 2022 10:41:11 +0200
Date:   Fri, 1 Jul 2022 10:41:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] dt-bindings: PCI: qcom: Add SC8280XP to binding
Message-ID: <Yr6zJ+KVeOHHcnRc@hovoldconsulting.com>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-5-johan+linaro@kernel.org>
 <2f3cc247-d56d-2338-d8e8-3ab32bf7f7ad@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f3cc247-d56d-2338-d8e8-3ab32bf7f7ad@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 10:37:55AM +0200, Krzysztof Kozlowski wrote:
> On 29/06/2022 16:09, Johan Hovold wrote:
> > Add the SC8280XP platform to the binding.
> > 
> > SC8280XP use four host interrupts for MSI routing so remove the obsolete
> > comment referring to newer chipsets supporting one or eight interrupts
> > (e.g. for backwards compatibility).
> > 
> 
> (...)
> 
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,pcie-sc8280xp
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          minItems: 4
> > +          maxItems: 4
> > +        interrupt-names:
> > +          items:
> > +            - const: msi0
> > +            - const: msi1
> > +            - const: msi2
> > +            - const: msi3
> 
> What the previous #3 commit is missing is:
> "This allows for adding further platforms with for example four MSI
> interrupts, without resorting to nested conditionals."

Yeah, that would make the comment more self-contained. I'll amend it if
I need to respin.

Johan
