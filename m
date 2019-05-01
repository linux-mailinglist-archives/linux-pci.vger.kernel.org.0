Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024BA10D9D
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 21:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfEAT6H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 15:58:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40258 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfEAT6G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 15:58:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id w6so48804otl.7;
        Wed, 01 May 2019 12:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KVYxrZh/5jWsZtB/YPLSce7+yNxAb7jrvHpWZlGvrBA=;
        b=p1VdhKn9XfX5Qz3vmfSGK2kmmnywg+RfRh8f+DHh62K2rXnzFCoPFkR515BQMnpCIT
         9tk9B39OlxJ0ULoYUWo9wm3e9vv/qe77Q6SSHoXd/KimDUVgddx4ZpHPz7EgNxCXrwFu
         iZb9sVOhJg0o4EwsNedsnDw6z4TcjJRM889qIh8aQmsFs2i1YI1uh6tUkrRXLRkUztbx
         5grKFIPORFY2aiZAXwrTK9m4mVCtb8+VLNmXTvmmWmAQ82lh1VD1bTql09niHfRmvB08
         JSUNrNFxtbmW4Uh6Ph5iL5Bx2wb4Ek7g6NKWI9OTIqaK2qFNq6pn1e6pkih1/sswl9QK
         B8jw==
X-Gm-Message-State: APjAAAV4deMlN0PDMYZvbHxIRak/f/e0KNQs1w+Y1tlUMoPy/3W9e6Bu
        bF5ohcNQSJhTMxq1F/C2qw==
X-Google-Smtp-Source: APXvYqyIhkEs42x21W9EtsXuim9fVAX29ijHpLJgaUrpTWnngVUjHvnzV7+kw2+N6rASSbJkdawZMA==
X-Received: by 2002:a05:6830:2092:: with SMTP id y18mr992445otq.319.1556740685958;
        Wed, 01 May 2019 12:58:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i11sm16004943otl.27.2019.05.01.12.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 12:58:05 -0700 (PDT)
Date:   Wed, 1 May 2019 14:58:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, bhelgaas@google.com,
        mark.rutland@arm.com, jonathanh@nvidia.com,
        lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 26/28] dt-bindings: pci: tegra: Document reset-gpio
 optional prop
Message-ID: <20190501195804.GA16435@bogus>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-27-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423092825.759-27-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 02:58:23PM +0530, Manikanta Maddireddy wrote:
> Document "reset-gpio" optional property which supports GPIO based PERST#
> signal.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: Using standard "reset-gpio" property
> 
>  .../devicetree/bindings/pci/nvidia,tegra20-pcie.txt          | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> index 7939bca47861..4e75e017f660 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> @@ -162,6 +162,10 @@ Required properties:
>    - Root port 0 uses 4 lanes, root port 1 is unused.
>    - Both root ports use 2 lanes.
>  
> +Optional properties:
> +- reset-gpio: If GPIO is used as PERST# signal instead of available
> +  SFIO, add this property with phandle to GPIO controller and GPIO number.

'reset-gpios' is the preferred form.

This is already defined in several other drivers. Perhaps document in a 
common location and also parse the property in common code.

Rob
