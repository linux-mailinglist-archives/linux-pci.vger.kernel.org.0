Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0822144E851
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 15:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhKLOSO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 09:18:14 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:11891 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhKLOSO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Nov 2021 09:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636726520;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bbeSZdJ7oNvfy+c2Ht92U/rHy+iyYkKun0+wmsZHsiA=;
    b=RJUKiGF0vEJda834NM39DMCpGAv6s9OBXad81e+PEiU8Oo8M+cpE1ZJ+PHeOYH5VnG
    0la+7VQP1KAbM1+mjZ0aLfQXBwWVfXu2Lv61MxY6ysAvWleIy7YCu7GirV6ChDgmJ8N+
    1rZjONSkI+VRHw9aN/QA+m2McvMnCLR/i7xzjRaWL2spMPPyTTZQCqJSyN2/q/mRNIZM
    PUJgHzM7y/zNVAFxCeY1iTy7A55wodrPS3ziOj7+bwJvIaqY8BwVlThwIBPomuju7G/l
    Lfuallvc/X01d5yAj9RQYcIm0Pe8aQA8/cIBhps9+mFbmW9rUl4LSuJBFTruZDfCVCVV
    4b6g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhWL7n8tmuiQcLNMDVOHy3jXR+anA=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a02:8109:89c0:ebfc:5949:d784:5886:5d22]
    by smtp.strato.de (RZmta 47.34.5 AUTH)
    with ESMTPSA id N03801xACEFITmk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 12 Nov 2021 15:15:18 +0100 (CET)
Message-ID: <a02c370d-1356-daac-25c4-02d222c91364@xenosoft.de>
Date:   Fri, 12 Nov 2021 15:15:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
Content-Language: de-DE
To:     Marc Zyngier <maz@kernel.org>
Cc:     "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        lorenzo.pieralisi@arm.com, Rob Herring <robh@kernel.org>,
        Matthew Leaman <matthew@a-eon.biz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Christian Zigotzky <info@xenosoft.de>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, kw@linux.com,
        Arnd Bergmann <arnd@arndb.de>, robert@swiecki.net,
        Olof Johansson <olof@lixom.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <3eedbe78-1fbd-4763-a7f3-ac5665e76a4a@xenosoft.de>
 <15731ad7-83ff-c7ef-e4a1-8b11814572c2@xenosoft.de>
 <17e37b22-5839-0e3a-0dbf-9c676adb0dec@xenosoft.de>
 <3b210c92-4be6-ce49-7512-bb194475eeab@xenosoft.de>
 <78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de>
 <87mtma8udh.wl-maz@kernel.org>
 <c95c9b58-347e-d159-3a82-bf5f9dbf91ac@xenosoft.de>
 <87lf1t8pab.wl-maz@kernel.org>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <87lf1t8pab.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12 November 2021 at 02:41 pm, Marc Zyngier wrote:
> On Fri, 12 Nov 2021 09:40:30 +0000,
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>> On 11 November 2021 at 06:39 pm, Marc Zyngier wrote:
>>> On Wed, 10 Nov 2021 18:07:24 +0000,
>>> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>>> On 09 November 2021 at 03:45 pm, Christian Zigotzky wrote:
>>>>> Hello,
>>>>>
>>>>> The Nemo board [1] doesn't recognize any ATA disks with the
>>>> pci-v5.16 updates [2].
>>>>> Error messages:
>>>>>
>>>>> ata4.00: gc timeout cmd 0xec
>>>>> ata4.00: failed to IDENTIFY (I/O error, error_mask=0x4)
>>>>> ata1.00: gc timeout cmd 0xec
>>>>> ata1.00: failed to IDENTIFY (I/O error, error_mask=0x4)
>>>>> ata3.00: gc timeout cmd 0xec
>>>>> ata3.00: failed to IDENTIFY (I/O error, error_mask=0x4)
>>>>>
>>>>> I was able to revert the new pci-v5.16 updates [2]. After a new
>>>> compiling, the kernel recognize all ATA disks correctly.
>>>>> Could you please check the pci-v5.16 updates [2]?
>>>>>
>>>>> Please find attached the kernel config.
>>>>>
>>>>> Thanks,
>>>>> Christian
>>>>>
>>>>> [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
>>>>> [2]
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4
>>>>
>>>> Hi All,
>>>>
>>>> Many thanks for your nice responses.
>>>>
>>>> I bisected today [1]. 0412841812265734c306ba5ef8088bcb64d5d3bd
>>>> (of/irq: Allow matching of an interrupt-map local to an interrupt
>>>> controller) [2] is the first bad commit.
>>> Can you please give the following hack a go and post the result
>>> (including the full dmesg)?
>>>
>>> Thanks,
>>>
>>> 	M.
>>> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>>> index 32be5a03951f..8cf0cc9b7caf 100644
>>> --- a/drivers/of/irq.c
>>> +++ b/drivers/of/irq.c
>>> @@ -156,14 +156,15 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>>>      	/* Now start the actual "proper" walk of the interrupt tree */
>>>    	while (ipar != NULL) {
>>> +		bool intc = of_property_read_bool(ipar, "interrupt-controller");
>>> +
>>>    		/*
>>>    		 * Now check if cursor is an interrupt-controller and
>>>    		 * if it is then we are done, unless there is an
>>>    		 * interrupt-map which takes precedence.
>>>    		 */
>>>    		imap = of_get_property(ipar, "interrupt-map", &imaplen);
>>> -		if (imap == NULL &&
>>> -		    of_property_read_bool(ipar, "interrupt-controller")) {
>>> +		if (imap == NULL && intc) {
>>>    			pr_debug(" -> got it !\n");
>>>    			return 0;
>>>    		}
>>> @@ -244,8 +245,14 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>>>      			pr_debug(" -> imaplen=%d\n", imaplen);
>>>    		}
>>> -		if (!match)
>>> +		if (!match) {
>>> +			if (intc) {
>>> +				pr_info("%pOF interrupt-map failed, using interrupt-controller\n", ipar);
>>> +				return 0;
>>> +			}
>>> +
>>>    			goto fail;
>>> +		}
>>>      		/*
>>>    		 * Successfully parsed an interrrupt-map translation; copy new
>>>
>> The detecting of the ATA disks works with this patch! Well done!
>> Thanks a lot!
> Thanks for testing it. I'll turn that into a proper patch.
>
> 	M.
>
Could you please explain your patch? I am not a developer. I work for 
the A-EON Linux FLS.

- Christian
