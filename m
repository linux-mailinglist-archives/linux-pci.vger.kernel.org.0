Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B85B2A6091
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 10:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgKDJdw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 04:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgKDJdu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 04:33:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7926BC0613D3
        for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2020 01:33:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a10so4517843edt.12
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2020 01:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1DyDheOb7hdP2j6+U4rmaA8px4hw4FKnG8K+MWzcbCY=;
        b=EQSmu7gHVfLkVF8VHKlfv0z9wC3WTiS8thx/WbFlnXuy03FTmdr6eI7gSMK+hKzlOX
         vzXdLk5eTEGMKBtye7uzKns5a1uXsQk7lWH2DdYAG9+bYlF2w9/MZ2e6ljk/mYqzjheB
         Olzmy9gyhEiX/6VLDcVwgs0Kuq+TF92bkOXzRshy5jkEtiac+3anQExlCRjj0lcuyk2l
         bRBKsOEM6ACzPe9fg5WRTAtzBUk1JKwQIdm2COAEQToBI8cSMpnuMkDNNSdThGhdp8wA
         0RIm6Pt8ng8j6NtVGkN8ALssajF5YOmP3ktUcTM6jdAydebyKA9Mcf7CzAgNYMJX6urQ
         fvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1DyDheOb7hdP2j6+U4rmaA8px4hw4FKnG8K+MWzcbCY=;
        b=MiSdWo8g57QjHOYLQMRceOrHXRUmzcz/rdsnrD2/j3ZTWTW8tSqbH6che0AwEs0hqG
         Rxqt8O4AAMsWvjbGlj5SgK9Y9hVJBMQ6VXqRyYnfV2eItJaoKqdtTMG1jyw9fdESMTbo
         4uyZziyx/ax6N99dPo2kkl8EYBUmljKfPEfDGIBVlq18DZQdHWCl8D8mhiMatmP1udgn
         ogIBt0rIA+IzxfppQa5mlgAMHXKodRA7nU0tbJMH4GQzR/9LyrkxTzz06OEAALvlnlzU
         K9NcBaJTkuANqpG2GKYmf8BsjbGjJQeAmRbmT3fLAzLrTZ61tF8dJP3lhavYP9xbrnuh
         TAyw==
X-Gm-Message-State: AOAM533tbyBPr9xqnhq3ua9fkJEePr/QqF1W6mnD85FarVNeipZzjLkD
        D3JZvKXza4zCtKz04Q6c4XjbKw==
X-Google-Smtp-Source: ABdhPJxwJwBOkJVz8J2LWuNKj/Ohtfm5+UYk8BmI+7+MjrwC4ykaiVvXA9wdH6bYcYvQ5FP9G4l5OQ==
X-Received: by 2002:aa7:da44:: with SMTP id w4mr14267958eds.131.1604482428113;
        Wed, 04 Nov 2020 01:33:48 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id b12sm726638edn.86.2020.11.04.01.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 01:33:47 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:33:28 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Al Stone <ahs3@redhat.com>
Cc:     Auger Eric <eric.auger@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20201104093328.GA505400@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <d54b674e-2626-fc73-d663-136573c32b8a@redhat.com>
 <20201002182348.GO138842@redhat.com>
 <e8a37837-30d0-d7cc-496a-df4c12fff1da@redhat.com>
 <20201103200904.GA1557194@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103200904.GA1557194@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Al,

On Tue, Nov 03, 2020 at 01:09:04PM -0700, Al Stone wrote:
> So, there are some questions about the VIOT definition and I just
> don't know enough to be able to answer them.  One of the ASWG members
> is trying to understand the semantics behind the subtables.

Thanks for the update. We dropped subtables a few versions ago, though, do
you have the latest v8?
https://jpbrucker.net/virtio-iommu/viot/viot-v8.pdf

> Is there a particular set of people, or mailing lists, that I can
> point to to get the questions answered?  Ideally it would be one
> of the public lists where it has already been discussed, but an
> individual would be fine, too.  No changes have been proposed, just
> some questions asked.

For a public list, I suggest iommu@lists.linux-foundation.org if we should
pick only one (otherwise add virtualization@lists.linux-foundation.org and
virtio-dev@lists.oasis-open.org). I'm happy to answer any question, and
the folks on here are a good set to Cc:

eric.auger@redhat.com
jean-philippe@linaro.org
joro@8bytes.org
kevin.tian@intel.com
lorenzo.pieralisi@arm.com
mst@redhat.com
sebastien.boeuf@intel.com

Thanks,
Jean
