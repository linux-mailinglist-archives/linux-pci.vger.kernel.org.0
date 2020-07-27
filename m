Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4664F22FB26
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 23:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgG0VPh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 17:15:37 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35801 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0VPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 17:15:37 -0400
Received: by mail-il1-f193.google.com with SMTP id t18so14404522ilh.2;
        Mon, 27 Jul 2020 14:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aqOi16jjOnKG2O05yH0kyUxh/Ipp8QMsuyogqi4nzKU=;
        b=r7QgxYvkQUH8rD3ZOeWR9notOWzHYxC4WEcfPlO7pf6TpQwoGLJFGTR41g8cfy8nu7
         HVNgAghlgAq6TPeFqGRsnx1mntnbxWycI46K7nqtaeWAdsiWOQlHwiFI/9WYFfcWhaR7
         JzfkRtHCHgn3zMHwMkV1c0FjxzHl2spEKpPKBT7QsDyg3JeO9Q9cUGxJMwbqGKv2QLuc
         ghu1O52JAm9lKgvx9DTrtcuhXxiGA0w7FD64B0y66ZyWa53x91nsPA79PwodRMFFN+La
         /Yzlbf7frrhIzrfsosyymWYi6lgb3lxnwo3i73QxxbVIS7HK6+chw2eaZ9BTEZJGkyb7
         Yd9w==
X-Gm-Message-State: AOAM531oUWDZnMjALNYy6PbZnIpmMPuF/ybfH44ai3Noyeo+rgjZxlHn
        kB/0ahf7kl28YtnaJofVEA==
X-Google-Smtp-Source: ABdhPJwxeh8JV9gP51L9KoRIkhHdJ1KYNRIHBeY3AeHjorP5YMvvt1YkkNkr1pHTdQ3JisHBWNDinw==
X-Received: by 2002:a05:6e02:dd1:: with SMTP id l17mr25068482ilj.136.1595884536970;
        Mon, 27 Jul 2020 14:15:36 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z68sm1472415ilf.25.2020.07.27.14.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:15:35 -0700 (PDT)
Received: (nullmailer pid 886288 invoked by uid 1000);
        Mon, 27 Jul 2020 21:15:33 -0000
Date:   Mon, 27 Jul 2020 15:15:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@qti.qualcomm.com>
Cc:     agross@kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-pci@vger.kernel.org, sivaprak@codeaurora.org,
        robh+dt@kernel.org
Subject: Re: [PATCH V2] dt-bindings: pci: convert QCOM pci bindings to YAML
Message-ID: <20200727211533.GA886087@bogus>
References: <1595776013-12877-1-git-send-email-sivaprak@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595776013-12877-1-git-send-email-sivaprak@qti.qualcomm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 26 Jul 2020 20:36:53 +0530, Sivaprakash Murugesan wrote:
> From: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> 
> Convert QCOM pci bindings to YAML schema
> 
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
> [v2]
>   - Referenced pci-bus.yaml
>   - removed duplicate properties already referenced by pci-bus.yaml
>   - Addressed comments from Rob
>  .../devicetree/bindings/pci/qcom,pcie.txt          | 330 ---------------
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 447 +++++++++++++++++++++
>  2 files changed, 447 insertions(+), 330 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> 

Applied, thanks!
