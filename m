Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC0D3BA7ED
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 10:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhGCIyI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Jul 2021 04:54:08 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:34649 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhGCIyI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Jul 2021 04:54:08 -0400
Received: by mail-ed1-f43.google.com with SMTP id i5so16589822eds.1
        for <linux-pci@vger.kernel.org>; Sat, 03 Jul 2021 01:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O+Kfmnl2EWxJSSuCIjQFLDmSQ7vmSswC4IMpgw5JJfo=;
        b=bvUuK4jfbu324xzgidfkbWgOF+3VqYojp7YGmPg0wHd+wnDm9JsUaErR+aszW0Ez2s
         BCXTQZKgmJKJPgoHwpgBgwPMiw8vcKBUpCknAqg3s95pMQNfoqYC7QHaiK1Z3618ds18
         Koo53azufuAXL9adIBfom4SmKS5TzYpljcAcooJTGZnRsShWyTNQcRPi0gx8OJIrc6gX
         88Sxw+bW+2K9FsZH7Zxcjk/Jzh4QZ8f6JKwZmOKwgmxcFmc5yditKofb9ZL806l5ClAG
         +4ATP88kM2oM0Ct9XjUZ/WdLk1U9bg6lWgAiNQ9OjRs/V4yU4f6cvsUJoU44Zb0moVNp
         ehzw==
X-Gm-Message-State: AOAM533HTOk8iaps1F+USBsoeRq/bne8lztePfMCIWS4hyL0o7AkRxBo
        nQnsoKhs4XONaSyLaeeeiBQ=
X-Google-Smtp-Source: ABdhPJxa9fB/gqpmrBYw+BO/+gQFyNBOcCxQZ1YPMrRfQ8SjCQVReXs9aAs3NuIilIa4MUdCXZOfCw==
X-Received: by 2002:a05:6402:c92:: with SMTP id cm18mr4142535edb.29.1625302293122;
        Sat, 03 Jul 2021 01:51:33 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id k21sm2302108edo.41.2021.07.03.01.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 01:51:32 -0700 (PDT)
Date:   Sat, 3 Jul 2021 10:51:31 +0200
From:   Krzysztof Wilczy??ski <kw@linux.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Scott Murray <scott@spiteful.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: hotplug: Fix kernel-doc formatting and add
 missing documentation
Message-ID: <20210703085131.GA427173@rocinante>
References: <20210702231541.1671875-1-kw@linux.com>
 <20210703064848.GA24279@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210703064848.GA24279@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

Thank you for feedback!

[...]
> I respectfully submit that the formatting is fine and there's nothing
> to be "fixed" here (as the commit message claims).

The fixing it probably more relevant to the two first hunks, everything
else would be more of a style update so that kernel-doc is kept with the
following guideline:
  https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html

Which is something other users of kernel-doc seldom embrace as I could
only find a handful of places where this format is somewhat followed.

Thus, like you say, keeping the scope of changes to only updating what
matters would be more appropriate.  I will send another revision that
does exactly that.

> > + * @inband_presence_disabled:	Flag to used to track whether the in-band
> > + *				presence detection is disabled.
> 
> That's not proper English and also not very useful because the documentation
> merely repeats what the flag's name says.  I'd suggest something along the
> lines of:
>  * @inband_presence_disabled: whether In-Band Presence Detect Disable is
>  *	supported by the controller and disabled per spec recommendation
>  *	(PCIe r5.0, appendix I implementation note)

Thank you!  I will use your version going forward.

	Krzysztof
