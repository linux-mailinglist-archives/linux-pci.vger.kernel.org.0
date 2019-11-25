Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC0D109314
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 18:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfKYRsX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 12:48:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34476 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfKYRsX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 12:48:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so19241736wrr.1
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2019 09:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BgkOCn6dEkaCecb5ZyLmsM0vtVrRc/X2TTNPZzp0BGs=;
        b=avnCZcmnWQYRn2ejXtbreBr+2fzx+QirQ6jMfKAMwEDo3jyctcQvSS6SM6aBRJCAeP
         kfDeyJNKwf8Ww1fdC45IB/7jKdswYHhGPaF1CAK1k/eHulj1Z8NDM4NLugYgnTl5DEOo
         YefFZFkbA6n3NhXip9hDUOr85MJpTQj4qNSE9VQlJPLdQNIY7YvpyPpEkKFXnyOnZTKk
         zxPRxvEFW8WTSxxiqEYBqSc/EW+pCq8OXdDzqUhlOxxL17HZqZAjCdkw8lFuH7Nliyrm
         MDDF0iP1wW7sCg4O3wkJdWYO3+EHez48clfhcdiT/8bJ80T/RuVV1xpWQm7lYwPafspo
         67oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BgkOCn6dEkaCecb5ZyLmsM0vtVrRc/X2TTNPZzp0BGs=;
        b=LEyD4WQS4MvfI+ZwFIwyv9CfxrPhagpw7+fmmRqL7cVAXIFnTIiBa56/rs9HKNlaqx
         EbQm+DoReRtPDjbA6MPO98TKVGa+6abANf4AGTaZcm4cf05JcLXTUbiJRQ8yuiEm1Mg8
         vwkgv7hGa14aviRlGXqLmxQ6XuYTAezxASSdL2nYpAMmXTR0axAP6xy2tVnRCF98kdPl
         2wJLzwZOSTETUAzFgY/jwG3ETiIc2mw3jBP9l2TXriW857gHPzWkakiFC2pS4McG1poN
         LrCasTQATI2rBy4jIu+lAJjD86xjT8cCBPGz7mAxVRQzV+HVWwpvgyoSqgLlp8QWOFp4
         lNpg==
X-Gm-Message-State: APjAAAWJ0PPSt2rBIXSeuWtHySPyLMRM8iL0j5OXpTfY6ff0Y/CA21Xc
        LviPoymPaYQRabCu8XKTBu8Lhg==
X-Google-Smtp-Source: APXvYqzTUYJqRjRrvNHNtPJwWI/KyemjW5baiqCvdsWHNGy9hgofkwoCe9NS+y/KmUwV3VIZ5E9NFQ==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr12150855wrs.106.1574704100857;
        Mon, 25 Nov 2019 09:48:20 -0800 (PST)
Received: from lophozonia (xdsl-188-155-204-106.adslplus.ch. [188.155.204.106])
        by smtp.gmail.com with ESMTPSA id x7sm11127238wrq.41.2019.11.25.09.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 09:48:20 -0800 (PST)
Date:   Mon, 25 Nov 2019 18:48:17 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        rjw@rjwysocki.net, lenb@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, bhelgaas@google.com,
        jasowang@redhat.com, jacob.jun.pan@intel.com,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com
Subject: Re: [RFC 13/13] iommu/virtio: Add topology description to
Message-ID: <20191125174817.GB945122@lophozonia>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
 <20191122105000.800410-14-jean-philippe@linaro.org>
 <20191122072753-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122072753-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 07:53:19AM -0500, Michael S. Tsirkin wrote:
> Overall this looks good to me. The only point is that
> I think the way the interface is designed makes writing
> the driver a bit too difficult. Idea: if instead we just
> have a length field and then an array of records
> (preferably unions so we don't need to work hard),
> we can shadow that into memory, then iterate over
> the unions.
> 
> Maybe add a uniform record length + number of records field.
> Then just skip types you do not know how to handle.
> This will also help make sure it's within bounds.
> 
> What do you think?

Sounds good, that should simplify the implementation a bit.

> You will need to do something to address the TODO I think.

Yes, I'll try to figure out a way to test platform devices.

> > +static void viommu_cwrite(struct pci_dev *dev, int cfg,
> > +			  struct viommu_cap_config *cap, u32 length, u32 offset,
> > +			  u32 val)
> 
> A single user with 4 byte parameter. Just open-code?

Ok

> > +		cap.head.type = viommu_cread(dev, pci_cfg, dev_cfg, 2, offset);
> > +		cap.head.next = viommu_cread(dev, pci_cfg, dev_cfg, 2, offset + 2);
> 
> All of this doesn't seem to be endian-clean. Try running sparse I think
> it will complain.

It does, I'll fix this

> > @@ -36,6 +37,31 @@ struct virtio_iommu_config {
> >  	struct virtio_iommu_range_32		domain_range;
> >  	/* Probe buffer size */
> >  	__le32					probe_size;
> > +	/* Offset to the beginning of the topology table */
> > +	__le16					topo_offset;
> 
> why do we need an offset?

I find it awkward to put a variable-size array in the middle of the
config. The virtio_iommu_config struct would be easier to extend later if
we keep the array at the end and only define small static fields here.

> 
> > +};
> > +
> > +struct virtio_iommu_topo_head {
> > +	__le16					type;
> > +	__le16					next;
> > +};
> 
> So this linked list makes things harder than necessary imho.
> It will be easier to just have a counter with # of records.
> Then make all records the same size.
> Then just read each record out into a buffer, and
> handle it there.

Yes, that should simplify things.

Thanks,
Jean
