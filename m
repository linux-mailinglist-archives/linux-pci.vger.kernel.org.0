Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C059F51E27F
	for <lists+linux-pci@lfdr.de>; Sat,  7 May 2022 01:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347039AbiEFWod (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 18:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391354AbiEFWoW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 18:44:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D168318360
        for <linux-pci@vger.kernel.org>; Fri,  6 May 2022 15:40:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g3so7189378pgg.3
        for <linux-pci@vger.kernel.org>; Fri, 06 May 2022 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=065LDUWhqHCWgMdSSFbFDlbRvxvwACfC87yilPrGdlI=;
        b=zBIqQHyP2DRtu8jz8+AeLb0ciWZUD2F8sqANruiZOVMvEMBEZAD3emBi/qQVdLHqzp
         FVHMU/GpxMUVJkH9RZzn+SAkcjpv4QVSuwQq5svgxeZZuJMAfI5wZmEpZr/PUNpF0trc
         v3FhaSLgSXaMB+u/Oj16M0ZDcapRGhaMUNu5wuOgExggSL2OpO6Q79H9C0m44+SLlmoK
         CGdmBpImvHG/vxatvNPDekkhw+VeGMDKncZSVQPPJN84rz/lbCUkxKFc0jAyjgd0j8bN
         XjopR/MAHgdcUIvAT/+tlwE2P5TQ9VWRpEznQWZ+5aS2XCz+uU3dwDcZAZ01ORpmZxyj
         NKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=065LDUWhqHCWgMdSSFbFDlbRvxvwACfC87yilPrGdlI=;
        b=rMA9hp2Tp7zJ3ZnvtLLXZ0I6MfF6rdYhrZ2d6yGoijvgw0ZoC1g8oBhxptkEfRWslc
         ar2fKK6FcT1SbgI8F3XikZMio0EicIBGO0/MsKvbG1p8G9K2qv44tHy0ObM0z7s+8X04
         TuwSzD3fgB6YrcmuDtvXHI7U6XqfOYUR45PQVWSmMKNcM1uyEV2YHxuLp4djKAEJDzRf
         MQaPCgAjHR9406XCPObG+e27Jq2YJTA63ns4jGWXa19hHzru4L2wbdbRH7Nf7IgA56ek
         /xmSYTiN3KejudyHMHsFreMtgUhWQbvYzL30RyyIZu84rBkJgNXEjnfmQn/R9Psi7j6T
         Obfg==
X-Gm-Message-State: AOAM533j7tSC/JSCCQxWOQqFu/+mFLvr9J+sNLgwzTyaRDImpzuPqPTk
        lMvGaht2Phrs8kbxgMZiaQG5+jXDHPMuy1Oh+PbGykJMo3gbQg==
X-Google-Smtp-Source: ABdhPJwmOiKypJh3j0YJSeDdlLbNrycMsjuELoXdkDcdp8bN/9RM2i9cleVTUpHB3xROZ6zQ4ez2oeSNjpMNfuP+Jtw=
X-Received: by 2002:a63:1117:0:b0:399:2df0:7fb9 with SMTP id
 g23-20020a631117000000b003992df07fb9mr4692066pgl.40.1651876836471; Fri, 06
 May 2022 15:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 6 May 2022 15:40:25 -0700
Message-ID: <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linuxarm <linuxarm@huawei.com>, "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        CHUCK_LEVER <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ add Lukas and Chuck ]

On Tue, May 3, 2022 at 8:35 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> So far, we have been considering Data Object Exchange (DOE) mailboxes only
> on EPs (CXL type 3 devices).
> CXL CDAT (technically CXL Table Query Protocol but lets just call it CDAT)
>   https://lore.kernel.org/linux-cxl/20220414203237.2198665-1-ira.weiny@intel.com
> CMA/SPDM support
>   https://lore.kernel.org/linux-cxl/20220303135905.10420-1-Jonathan.Cameron@huawei.com/
>
> However, a number of DOE protocols apply to switch (and root) ports.
> DOE instances supporting CDAT occur on switch upstream ports as well as EPs.
>
> DOE instances supporting CMA may occur in root ports, upstream switch ports,
> downstream switch ports and EPs (including multiple functions where relevant).
>

So, like you, I was envisioning all the CMA and SPDM code landing in
the kernel until I read this:

"Extending in-kernel TLS support"
https://lwn.net/Articles/892216/

...and questioned why this new CMA/SPDM session establishment, which
is similar to TLS, be done inside the kernel while TLS session
establishment is done in userspace? I had a chance to chat with Chuck
at LSF/MM and confirmed there is little appetite to change this
up-call requirement for session establishment and expect CMA to be the
same. The rough idea of how this works with CMA/SPDM is providing an
ABI to retrieve session setup data with the end result of userspace
instantiating a keyid via keyctl the to be used for future SPDM
messages.

> The intent of this RFC is to discuss how to actually implement such support.
> The attached patch is a really rough PoC for CDAT on upstream switch ports
> done by adding a new pcie_port_service_driver.  This is different from the
> proposed auxiliary device used for CXL type 3 devices (for now).

CDAT to me is on the "CXL" side of a given PCI device. Given that
endpoints and switches are each represented by cxl_port objects it
seems those should generically carry the CDAT binary attribute, not
the PCI device, don't you think?

>
> So open questions:
>
> 1. Granularity. Should we do a driver per group of protocols that may
>    be collocated, or one per DOE instance. For now, we might be looking
>    at CDAT as done for this PoC, and CMA/IDE.

The more time goes by the more I am coming around to Bjorn's initial
reaction to all this that DOE is closer to a VPD model than an
auxiliary_device model or pcie_port_device model.

I.e. have some common discovery in the PCI core for enumerating DOE
instances and advertisting protocols, but otherwise leave it up to
individual leaf drivers like cxl_pci or cxl_port to use that core to
run a given protocol.

> 2. Use of a pcie_port_service_driver a reasonable way to do this?
> 3. Service provision. It is likely that all of the protocols defined
>    above will be used as part of activities that span multiple devices.
>    a) CDAT used to establish latencies and bandwidth between host CPU
>       and memory on a CXL type 3 device beyond one or more CXL switches.
>    b) CMA.  Might just be used to provide simple device attestation
>       and potentially lock out the upstream port above a switch if the
>       switch does not pass attestation.  Many many other uses possible...

Per above once userspace has installed an SPDM session keyid for a
given PCI device it can also optionally set an 'authorized' attribute
(similiar to what USB and Thunderbolt have) to indicate whether a
device has passed attestation. As for the actual protocols that are
going to run over the SPDM session those would need their own drivers
that reference the established keyid.

>    c) Secure CMA / IDE. Likely to be used to set up link IDE.  What
>       this will look like is a question I've not really started
>       thinking about yet.
>
>    So how do we support this?  If nothing else we need to make sure
>    the drivers for the port don't go away whilst in use.

Another reason to make it a core aspect of the PCI device like VPD so
there are no entanglements beyond "PCI device exists".

> The patch is a very early PoC just to show it would 'work'...
>
> Note I am keen to not have the discussion around this support delay
> Ira's series.

Is there a nearer term forcing function for this? I.e. v5.20 seems to
be where the current DOE series is going to intercept. I think abandon
the "aux" organization for now and make DOE like VPD.
