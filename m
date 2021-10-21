Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C964367CA
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 18:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhJUQct (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 12:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUQct (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 12:32:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1BC061764;
        Thu, 21 Oct 2021 09:30:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso3539654pjm.4;
        Thu, 21 Oct 2021 09:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lc2V8kW9DWjIh5PwTRqiTR+Qdm9DCZ56d3CfgkVtsAg=;
        b=KuDBSYgshNz9/GCM1Jkbz7X3nsWyxLk7hvxcjDbgj2f+N3J2vjdaq7KVZsGcSNocHf
         pMaNHrJ5ZwHL38XdgC6QleKmA2D81frhRfhI9iPcj9GYH78bb1Nlt2LXE6s4eakmlC1C
         YY2KiZqTVXORECOLw0be0vs2dOsf2m1cyKFZB9E5TJvohcma/0P8dxtyYEikqf591vPp
         X4fBU35cfhcGSzdmFwJnJgWcj03FLgViEoeTO3fzri7jaHSUdzlZtW6qkhhEmFtYWPcp
         ApO6iqy1iDToJt+y0rvB5+29nVoGOieKLQJYFCO7E6YzBy5afnoHSPUxsk03JZHQSjIT
         +2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lc2V8kW9DWjIh5PwTRqiTR+Qdm9DCZ56d3CfgkVtsAg=;
        b=uMc8ynu91NGAqwVK0h4gsHhm9C56KOTS9j/5wQCeU/e/chrne687ClL9x8Uu1pYTKs
         GNfl3iyXHfFF/78OHPK/7Zn7Nm1DNuHlc72zyz8BzfcKF2cz86Q4Aws/zCwjMvEBOiB5
         aeW1ho4eS5aZVvdtsPaSg7VvRniT1R0Pzw/2nldUkHLgTkLdu/YMPO5d21IPESCS9dsv
         4ZyI5I+Pyv+F2HFRIJhq8VksutxZNXCDcAl7chEYaodS0O6f+dZF5JcYfVQVvrnCwKYe
         PX1n+GbMk6u+XE0R6c4iE/D/VYVd+DXVgUm2/hGw8i/4pQxR22sG7KR5KdRcx3qxY+j9
         i+cg==
X-Gm-Message-State: AOAM530izInSzUL8Qs+mW8Cm3eE9agHr/QxnY68t/AAyhLCYl49xjtVq
        doKm57klVSyZk661ELZjC+o=
X-Google-Smtp-Source: ABdhPJxOnUbbOM9WGG3ZOvhQwiI9j78jVo97pCwncL8rKO/wgLLb9naCikt2yiq01L3UPck2/PDSEA==
X-Received: by 2002:a17:90a:9bca:: with SMTP id b10mr7852273pjw.133.1634833832448;
        Thu, 21 Oct 2021 09:30:32 -0700 (PDT)
Received: from theprophet ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id d60sm9876076pjk.49.2021.10.21.09.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:30:31 -0700 (PDT)
Date:   Thu, 21 Oct 2021 22:00:21 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4 1/8] PCI/AER: Remove ID from aer_agent_string[]
Message-ID: <20211021163021.r4ekhfol42ftw5zw@theprophet>
References: <22b2dae2a6ac340d9d45c28481d746ec1064cd6c.1633453452.git.naveennaidu479@gmail.com>
 <20211021012826.GA2655655@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021012826.GA2655655@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/10, Bjorn Helgaas wrote:
> On Tue, Oct 05, 2021 at 10:48:08PM +0530, Naveen Naidu wrote:
> > Currently, we do not print the "id" field in the AER error logs. Yet the
> > aer_agent_string[] has the word "id" in it. The AER error log looks
> > like:
> > 
> >   pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
> > 
> > Without the "id" field in the error log, The aer_agent_string[]
> > (eg: "Receiver ID") does not make sense. A user reading the
> > aer_agent_string[] in the log, might inadvertently look for an "id"
> > field and not finding it might lead to confusion.
> > 
> > Remove the "ID" from the aer_agent_string[].
> > 
> > The following are sample dummy errors inject via aer-inject.
> 
> I like this, and the problem it fixes was my fault because
> these "ID" strings should have been removed by 010caed4ccb6.
> 
> If it's straightforward enough, it would be nice to have the
> aer-inject command line here in the commit log to make it easier
> for people to play with this.
>

Thank you for the review. Do you mean something like:

The following sample dummy errors are injected via aer-inject via the
following steps:

  1. The steps to compile the aer-inject tool is mentioned in (Section
     4. Software error inject) of the document [1]

     [1]: https://www.kernel.org/doc/Documentation/PCI/pcieaer-howto.txt

     Make sure to place the aer-inject executable at the home directory
     of the qemu system or at any other place.

  2. Emulate a PCIE architecture using qemu, A sample looks like
     following:
     
		qemu-system-x86_64 -kernel ../linux/arch/x86_64/boot/bzImage \
        -initrd  buildroot-build/images/rootfs.cpio.gz \
        -append "console=ttyS0"  \
        -enable-kvm -nographic \
        -M q35 \
        -device pcie-root-port,bus=pcie.0,id=rp1,slot=1 \
        -device pcie-pci-bridge,id=br1,bus=rp1 \
        -device e1000,bus=br1,addr=8
       
    Note that the PCIe features are available only when using the 
    'q35' Machine [2]
    [2]: https://github.com/qemu/qemu/blob/master/docs/pcie.txt

  3. Once the qemu system starts up, create a sample aer-file or use any
     example aer file from [3]

     [3]:
     https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/tree/examples

  4. Inject any aer-error using
      
      ./aer-inject aer-file

This does look a tad bit longer for a commit log so I am unsure if you
would like to have it there. If you are okay with it, I would be happy
to add it to that :)

> > Before
> > =======
> > 
> > In 010caed4ccb6 ("PCI/AER: Decode Error Source Requester ID"),
> > the "id" field was removed from the AER error logs, so currently AER
> > logs look like:
> > 
> >   pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03:0
> >   pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID) <--- no id field
> >   pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
> >   pcieport 0000:00:03.0:    [ 6] BadTLP
> > 
> > After
> > ======
> > 
> >   pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03.0
> >   pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver)
> >   pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
> >   pcieport 0000:00:03.0:    [ 6] BadTLP
> > 
> > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > ---
> >  drivers/pci/pcie/aer.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 9784fdcf3006..241ff361b43c 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -516,10 +516,10 @@ static const char *aer_uncorrectable_error_string[] = {
> >  };
> >  
> >  static const char *aer_agent_string[] = {
> > -	"Receiver ID",
> > -	"Requester ID",
> > -	"Completer ID",
> > -	"Transmitter ID"
> > +	"Receiver",
> > +	"Requester",
> > +	"Completer",
> > +	"Transmitter"
> >  };
> >  
> >  #define aer_stats_dev_attr(name, stats_array, strings_array,		\
> > @@ -703,7 +703,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> >  	const char *level;
> >  
> >  	if (!info->status) {
> > -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> > +		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent)\n",
> >  			aer_error_severity_string[info->severity]);
> >  		goto out;
> >  	}
> > -- 
> > 2.25.1
> > 
> > _______________________________________________
> > Linux-kernel-mentees mailing list
> > Linux-kernel-mentees@lists.linuxfoundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
