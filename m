Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E03A77F4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 02:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfIDAzY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 20:55:24 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41222 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfIDAzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2019 20:55:24 -0400
Received: by mail-yb1-f195.google.com with SMTP id 1so6685589ybj.8
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2019 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BGjyfu/3FBGMF3xyvxxIMy1eqm67FZbwbJlNeNhhLUA=;
        b=KWgZddVnWnPahpv4TiomF9kFAEXEN68wVV8OFnZ90ooYWHfWDwKqWo7Iq1OCqRRMAL
         6Pv79sqtIoSH2VZW9lHsGaAhqlDw4SKD9EWw5eEs3qvoFsRnjzJAoqZOnP5E6JPh3U3z
         GWWgWSxeEVTqLSj+gdPETikwzE+ZyRmBMHxx4yKOFFM6UIWBM6KWBdvUC6B6AN5Qu2fx
         eCxtN4LXzqjH7ajDnuTngE5e29NghDfTQXZ2sUEb+vNXuGISSry1iBkKN1FryF9g7X5r
         59uGFJGeQmaNxcEL6Yga8N5oS/ss14pfX3rGPUigwMx/1D7FabwLWDyRuTiz5ZIk4Tvo
         hjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BGjyfu/3FBGMF3xyvxxIMy1eqm67FZbwbJlNeNhhLUA=;
        b=eMH58D8j0LczqMZ/d3qvCpWHu/MRrdYrylXN592GuSOXlCmiLsXELR2vDocadKCqDb
         yLus80oJZg8wfwjGCwLKL4yhQEnWvdBnc686gzx6cPXXqZ9FAw+D6a8yrbtej2AtWYMd
         B+m6yWA7vqtON9P2PMbYqPX2VM1DK5bVgqHwOe21mJexJQ+1NHTkOIdqiPwrAWk/HNmZ
         XgMTNod/soZ5U8fxE4qJdXVm+WF9K5iA0I77w5MFjsJD/hlhgfjH0uzKRNH5JHyzdef3
         5dEvQrjmhDC0lgGGkrIf81Im7xvRR9ZsyYJvR1erblhVyRtcRQzLDemN0unZQxmriYmk
         h/SQ==
X-Gm-Message-State: APjAAAUU5QotB0zmNu99SXTQNGVdnDu6lt3xoc2jBvPbjuButSFe1UDT
        Y6zVrIehe2wKBrI3Se6mk6FAPygb6tE9J8+n
X-Google-Smtp-Source: APXvYqwMqna2GYkdyCxfiaM4NQL1T8dDFQbGOpfj+G/O9Qu04iZjX8emqQQExBG/pQH1JElAZLFMHg==
X-Received: by 2002:a25:9908:: with SMTP id z8mr25830420ybn.283.1567558523523;
        Tue, 03 Sep 2019 17:55:23 -0700 (PDT)
Received: from jaxon.localdomain ([152.3.43.56])
        by smtp.gmail.com with ESMTPSA id f68sm1275607ywb.96.2019.09.03.17.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 17:55:23 -0700 (PDT)
From:   Haotian Wang <haotian.wang@sifive.com>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        mst@redhat.com
Cc:     linux-pci@vger.kernel.org, haotian.wang@duke.edu
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
Date:   Tue,  3 Sep 2019 20:55:22 -0400
Message-Id: <20190904005522.2190-1-haotian.wang@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <7067e657-5c8e-b724-fa6a-086fece6e6c3@redhat.com>
References: <7067e657-5c8e-b724-fa6a-086fece6e6c3@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 3, 2019 at 6:42 AM Jason Wang <jasowang@redhat.com> wrote:
> So if I understand correctly, what you want is:
> 
> 1) epf virtio actually represent a full virtio pci device to the host 
> Linux.
> 2) to endpoint Linux, you also want to represent a virtio device (by 
> copying data between two vrings) that has its own config ops
> 
> This looks feasible but tricky. One part is the feature negotiation. You 
> probably need to prepare two set of features for each side. Consider in 
> your case, you claim the device to support GUEST_CSUM, but since no 
> HOST_CUSM is advertised, neither side will send packet without csum. And 
> if you claim HOST_CUSM, you need to deal with the case if one of side 
> does not support GUEST_CSUM (e.g checksum by yourself). And things will 
> be even more complex for other offloading features. Another part is the 
> configuration space. You need to handle the inconsistency between two 
> sides, e.g one side want 4 queues but the other only do 1.

You are right about the two bullet points. You are also right about the
two sets of features.

When I put GUEST_CSUM and HOST_CSUM in both devices' features, I always
got the error that packets had incorrect "total length" in ip headers.
There were a bunch of other problems when I tried to implement the other
kinds of offloading.

Also, I encountered another inconsistency with the virtio 1.1 spec.
According to the spec, when legacy interface was used, we were supposed
to put the virtio_net_hdr and the actual packet in two different
descriptors in the rx queue. After a lot of trial and error, packets
were supposed to be put directly after the virtio_net_hdr struct,
together in the same descriptor.

Given that, I still did not address the situations where the two sides
had different features. Therefore, the solution right now is to hardcode
the features the epf support in the source code, including offloading
features, mergeable buffers and number of queues.

> > Also that design uses the conventional virtio/vhost framework. In this
> > epf, are you implying instead of creating a Device A, create some sort
> > of vhost instead?
> 
> 
> Kind of, in order to address the above limitation, you probably want to 
> implement a vringh based netdevice and driver. It will work like, 
> instead of trying to represent a virtio-net device to endpoint, 
> represent a new type of network device, it uses two vringh ring instead 
> virtio ring. The vringh ring is usually used to implement the 
> counterpart of virtio driver. The advantages are obvious:
> 
> - no need to deal with two sets of features, config space etc.
> - network specific, from the point of endpoint linux, it's not a virtio 
> device, no need to care about transport stuffs or embedding internal 
> virtio-net specific data structures
> - reuse the exist codes (vringh) to avoid duplicated bugs, implementing 
> a virtqueue is kind of challenge

Now I see what you mean. The data copying part stays the same but that
data copying stays transparent to the whole vhost/virtio framework. You
want me to create a new type of network_device based on vhost stuff
instead of epf_virtio_device. Yeah, that is doable.

There could be performance overheads with using vhost. The
epf_virtio_device has the most straightforward way of calling callback
functions, while in vhost I would imagine there are some kinds of task
management/scheduling going on. But all this is congesture. I will write
out the code and see if throughput really dropped.

Thanks for clarifying.

Best,
Haotian
