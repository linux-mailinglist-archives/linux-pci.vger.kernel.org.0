Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73F0248B99
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHRQ2B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 12:28:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55393 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727102AbgHRQ1d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2020 12:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597768047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=if9LpYICK0NhGXF5AA8XXB22L0fg+m6z8gcS1Q79zUU=;
        b=c7TB2s4nJZZtfxADyn2lGRVDOg1erPbexqz5JyHkRdT+GVyKZIv8FYzpmAr1N2W1yhNfBo
        WFTatipZ0ZxQuqde/DYFHWPh92se4d5i4khHQXSet1JybgZOjiQGC79wTJbqnebvWdl6oo
        EAHIc2eh+REJPofVh8YIU9MWgLr50Bk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-6vuCdo16Oyuou361Eoac2g-1; Tue, 18 Aug 2020 12:27:25 -0400
X-MC-Unique: 6vuCdo16Oyuou361Eoac2g-1
Received: by mail-wm1-f72.google.com with SMTP id g72so6301903wme.4
        for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2020 09:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=if9LpYICK0NhGXF5AA8XXB22L0fg+m6z8gcS1Q79zUU=;
        b=ijN5cuzh53727A2McnrTblbI7Fw7KxyEzXo/Tn0/fW19NpW0xqQt9cpGFpHA1ZbVwa
         6fWaW3oM9EhYHYhd4A59QstkaVnuwAZDTad7bTCfUikRx27CzucFsND6FRSAtlYO/r29
         w39DCL3sVSO4xZlG5km+AP/z8hfMiQNC7AXkxWGBmTuCi7feFvIdFJc/3sM8pXJwCgN7
         NvjJwtWmveqtAtyBbmmmIQAOZbvqdNr0zsrnLFHHzm+8g8Is3NkgmEocZdnV7E5d/e0M
         i/fqPlbWBPw3KV/vwK63ard70FBrNNG36wLQWejQfIZOeg6zMmvHiOVOrPPZQGC0paqN
         zNmw==
X-Gm-Message-State: AOAM533cl7DtGurryXeIGL9wMSa8yCYLZUSvERfDEJXIUMBKzGhQ27sV
        BsmJbvh2RN8GdzHw3FG3d3ct/uIXwpCpGMNVhUo9jWdOnxNGMx46Oro6VJ+qQMW72pmViCXxdCI
        VCXNzUjcCVjT+2uCjBoS1
X-Received: by 2002:a7b:cf29:: with SMTP id m9mr692491wmg.88.1597768044064;
        Tue, 18 Aug 2020 09:27:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykPaZdW75tblNPwohfUTSZAywU3pLEZHF86kgfsgbeUM6YEol+VFwyiwZdqftvl2orXJtznA==
X-Received: by 2002:a7b:cf29:: with SMTP id m9mr692461wmg.88.1597768043853;
        Tue, 18 Aug 2020 09:27:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:38e0:ccf8:ca85:3d9b? ([2001:b07:6468:f312:38e0:ccf8:ca85:3d9b])
        by smtp.gmail.com with ESMTPSA id e5sm37696385wrc.37.2020.08.18.09.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 09:27:23 -0700 (PDT)
Subject: Re: [PATCH RFC v2 00/18] Add VFIO mediated device support and DEV-MSI
 support for the idxd driver
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Dey, Megha" <megha.dey@intel.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Lu, Baolu" <baolu.lu@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "netanelg@mellanox.com" <netanelg@mellanox.com>,
        "shahafs@mellanox.com" <shahafs@mellanox.com>,
        "yan.y.zhao@linux.intel.com" <yan.y.zhao@linux.intel.com>,
        "Ortiz, Samuel" <samuel.ortiz@intel.com>,
        "Hossain, Mona" <mona.hossain@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20200721164527.GD2021248@mellanox.com>
 <CY4PR11MB1638103EC73DD9C025F144C98C780@CY4PR11MB1638.namprd11.prod.outlook.com>
 <20200724001930.GS2021248@mellanox.com> <20200805192258.5ee7a05b@x1.home>
 <20200807121955.GS16789@nvidia.com>
 <MWHPR11MB16452EBE866E330A7E000AFC8C440@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200814133522.GE1152540@nvidia.com>
 <MWHPR11MB16456D49F2F2E9646F0841488C5F0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200818004343.GG1152540@nvidia.com>
 <MWHPR11MB164579D1BBBB0F7164B07A228C5C0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200818115003.GM1152540@nvidia.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0711a4ce-1e64-a0cb-3e6d-f6653284e2e3@redhat.com>
Date:   Tue, 18 Aug 2020 18:27:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200818115003.GM1152540@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/08/20 13:50, Jason Gunthorpe wrote:
> For instance, what about suspend/resume of containers using idxd?
> Wouldn't you want to have the same basic approach of controlling the
> wq from userspace that virtualization uses?

The difference is that VFIO more or less standardizes the approach you
use for live migration.  With another interface you'd have to come up
with something for every driver, and add support in CRIU for every
driver as well.

Paolo

